import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:servizo_vendor/app/Model/khata_bills_resp.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/modules/MakeKhataBills/views/share_pdf_bill.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';

import '../controllers/khata_bills_controller.dart';

class KhataBillsView extends GetView<KhataBillsController> {
  const KhataBillsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: backButton(),
        title: Text(
          controller.clientName.value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Obx(() {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _filterButton("All Time", controller),
                      const SizedBox(width: 8),
                      _filterButton("Last 30 Days", controller),
                      const SizedBox(width: 8),
                      _filterButton("Last 15 Days", controller),
                      const SizedBox(width: 8),
                      _filterButton(
                        "Custom Range",
                        controller,
                        isCustom: true,
                        context: context,
                      ),
                    ],
                  ),
                );
              }),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: Obx(() {
                if (!controller.khataBillLoaded.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Get.theme.primaryColor,
                    ),
                  );
                }
                if (controller.khataBillData.isEmpty) {
                  return noData();
                }

                return ListView.separated(
                  itemCount: controller.khataBillData.length,
                  separatorBuilder: (context, index) => const SizedBox(),
                  itemBuilder: (context, index) {
                    final KhataBillData bill = controller.khataBillData[index];

                    final dateString = bill.createdAt;
                    final formattedDate =
                        dateString.isNotEmpty
                            ? DateFormat(
                              "dd MMM yyyy • hh:mm a",
                            ).format(DateTime.parse(dateString))
                            : "Unknown";

                    return InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        if (bill.items.isNotEmpty) {
                          Get.to(
                            () => BillPreviewPage(
                              bill: bill,
                              billitems: bill.items[0],
                            ),
                          );
                        }
                      },
                      child: _billCard(
                        billNo: bill.billId.toString(),
                        itemName:
                            bill.heading.isNotEmpty
                                ? bill.heading
                                : "Bill #${bill.billId}",
                        customer: bill.customerName,
                        amount: "₹${bill.total}",
                        status: bill.isPaid,
                        date: formattedDate,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),

      // FAB
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(
            Routes.MAKE_KHATA_BILLS,
            arguments: {
              "ClientId": controller.clientID.value,
              "CustomerName": controller.clientName.value,
            },
          );
        },
        label: const Text(
          "Create Bill",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Get.theme.primaryColor,
        elevation: 4,
      ),
    );
  }

  /// Custom Bill Card
  static Widget _billCard({
    String? billNo,
    String? customer,
    bool? status,
    String? itemName,
    String? amount,
    String? date,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Left side icon + status
            Column(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Get.theme.primaryColor.withOpacity(.1),
                  child: Icon(
                    Icons.receipt_long,
                    color: Get.theme.primaryColor,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color:
                        status! ? Get.theme.primaryColor : Colors.red.shade600,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status ? "PAID" : "UNPAID",
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 14),

            // Middle: details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    customer ?? "",
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    date ?? "",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount ?? "",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:
                        status ? Get.theme.primaryColor : Colors.red.shade800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _filterButton(
  String label,
  KhataBillsController controller, {
  bool isCustom = false,
  BuildContext? context,
}) {
  final isSelected = controller.selectedFilter.value == label;
  return OutlinedButton(
    onPressed: () async {
      if (isCustom && context != null) {
        DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          controller.selectedFilter.value = label;
          controller.applyFilter(startDate: picked.start, endDate: picked.end);
        }
      } else {
        controller.selectedFilter.value = label;
        controller.applyFilter();
      }
    },
    style: OutlinedButton.styleFrom(
      shape: const StadiumBorder(),
      side: BorderSide(
        color: isSelected ? Get.theme.primaryColor : Colors.grey.shade400,
        width: isSelected ? 2 : 1,
      ),
      foregroundColor:
          isSelected ? Get.theme.primaryColor : Colors.grey.shade600,
      backgroundColor:
          isSelected
              ? Get.theme.primaryColor.withOpacity(.1)
              : Colors.transparent,
    ),
    child: Text(label),
  );
}
