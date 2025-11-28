import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:servizo_vendor/app/Model/khata_bills_resp.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/modules/MakeKhataBills/app_heading.dart';
import 'package:servizo_vendor/app/modules/MakeKhataBills/controllers/make_khata_bills_controller.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class BillPreviewPage extends StatelessWidget {
  final controller = Get.put(MakeKhataBillsController());
  final KhataBillData bill;
  final BillItem billitems;
  final ScreenshotController screenshotController = ScreenshotController();

  BillPreviewPage({super.key, required this.bill, required this.billitems});

  @override
  Widget build(BuildContext context) {
    final RxBool isPaid = (bill.isPaid).obs;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: backButton(),
        title: heading('Invoice Preview', ''),
        actions: [
          Obx(
            () => Text(
              isPaid.value ? "PAID" : "UNPIAD",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color:
                    isPaid.value ? Get.theme.primaryColor : Colors.red.shade700,
              ),
            ),
          ),
          SizedBox(width: 5),
          Obx(
            () => Switch(
              value: isPaid.value,
              onChanged: (val) {
                isPaid.value = val;
                controller.updateBillPayStatus(
                  billId: bill.billId,
                  status: isPaid.value ? 1 : 0,
                );
              },
              activeColor: Get.theme.primaryColor,
              inactiveThumbColor: Colors.red,
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: ListView(
        children: [
          Screenshot(
            controller: screenshotController,
            child: Container(
              color: Get.theme.scaffoldBackgroundColor,
              child: Column(
                children: [
                  _buildInvoiceCard(),
                  const SizedBox(height: 10),

                  // 🔘 Paid / Unpaid Switch
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),

          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Get.theme.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Share Invoice",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                final image = await screenshotController.capture();
                if (image != null) {
                  final directory = await getApplicationDocumentsDirectory();
                  final imagePath = File('${directory.path}/invoice.png');
                  await imagePath.writeAsBytes(image);
                  final String message =
                      "Hi ${bill.customerName}, this is your invoice for ${billitems.itemName}.";
                  await Share.shareXFiles([
                    XFile(imagePath.path),
                  ], text: message);
                }
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInvoiceCard() {
    double totalNetPrice = 0;
    double totalGST = 0;
    double totalCESS = 0;

    for (var item in bill.items) {
      double itemSubtotal = item.price * item.quantity;
      totalNetPrice += itemSubtotal;
      totalGST += itemSubtotal * item.gstPercent / 100;
      totalCESS += itemSubtotal * (item.cessPercent ?? 0) / 100;
    }
    final formatter = DateFormat('dd-MM-yyyy hh:mm a');

    return Card(
      color: Get.theme.scaffoldBackgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- HEADER ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TAX INVOICE",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Invoice No: ${bill.billId}",
                      style: const TextStyle(fontSize: 12),
                    ),

                    Text(
                      "Date: ${formatter.format(DateTime.parse(bill.createdAt))}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Due Date: ${formatter.format(DateTime.parse(bill.createdAt))}", // use actual dueDate field if available
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Image.asset(
                  bill.isPaid
                      ? "assets/image/paid.png"
                      : "assets/image/unpaid.png",
                  height: 80,
                ),
              ],
            ),
            const Divider(height: 24),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _addressBox(
                    title: bill.customerName,
                    name: bill.heading,
                    gstin: bill.gstid,

                    address: "44, MG Road, Bangalore",
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _addressBox(
                    title: bill.heading,
                    name: bill.customerName,
                    gstin: bill.gstid,
                    address: bill.address,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Table(
              border: TableBorder.all(color: Colors.grey.shade300, width: 0.7),
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(1.4),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(1.5),
              },
              children: [
                _tableHeaderRow(["Item", "HSN", "Qty", "GST", "Total"]),

                ...bill.items.map((item) {
                  final subtotal = item.price * item.quantity;

                  return TableRow(
                    children: [
                      _cell(item.itemName.toUpperCase()),
                      _cell(item.hsn),
                      _cell("${item.quantity}"),
                      _cell("${item.gstPercent}%"),
                      _cell("₹${subtotal.toStringAsFixed(2)}"),
                    ],
                  );
                }),
              ],
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Get.theme.primaryColor.withOpacity(.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _totalRow("Unit Price", totalNetPrice),
                  _totalRow("GST", totalGST),
                  _totalRow("CESS", totalCESS),
                  const Divider(),
                  Text(
                    "Grand Total: ₹${bill.total.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "In Words: Forty-Two Thousand Four Hundred Eighty Only",
                    style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Text(
              "Terms & Conditions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Get.theme.primaryColor,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "1. Payment due within 15 days.",
              style: TextStyle(fontSize: 11),
            ),
            const Text(
              "2. Interest @ 14% will be charged on delayed payments.",
              style: TextStyle(fontSize: 11),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                "Thank you for your business!",
                style: TextStyle(
                  fontSize: 12,
                  color: Get.theme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(height: 30, child: AppHeadingWidget()),
          ],
        ),
      ),
    );
  }

  // ---------- HELPERS ----------
  Widget _addressBox({
    required String title,
    required String name,
    required String gstin,

    required String address,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 0.7),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
          Text("GSTIN: $gstin", style: const TextStyle(fontSize: 11)),

          Text(address, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  TableRow _tableHeaderRow(List<String> headers) {
    return TableRow(
      decoration: BoxDecoration(color: Get.theme.primaryColor.withOpacity(.1)),
      children: headers.map((h) => _cell(h, bold: true)).toList(),
    );
  }

  Widget _cell(String text, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _totalRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        "$label: ₹${value.toStringAsFixed(2)}",
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
