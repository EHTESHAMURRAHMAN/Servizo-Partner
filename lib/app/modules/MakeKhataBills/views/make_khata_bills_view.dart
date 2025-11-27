import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/make_khata_bills_controller.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';

class MakeKhataBillsView extends GetView<MakeKhataBillsController> {
  const MakeKhataBillsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: backButton(),
          title: heading("Generate Bill", ''),
          bottom: const TabBar(
            tabs: [Tab(text: "Add Items"), Tab(text: "Review Bill")],
          ),
        ),
        body: const TabBarView(children: [_AddItemsTab(), _ReviewTab()]),
      ),
    );
  }
}

class _AddItemsTab extends GetView<MakeKhataBillsController> {
  const _AddItemsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _inputField(
          controller.customerController,
          "Customer Name",
          icon: CupertinoIcons.person,
        ),
        const SizedBox(height: 8),
        _inputField(
          controller.headingController,
          "Invoice Name",
          icon: CupertinoIcons.doc,
        ),
        const SizedBox(height: 8),
        _inputField(
          controller.gstController,
          "GST Number (Optional)",
          icon: Icons.percent,
        ),
        const SizedBox(height: 8),
        _inputField(
          controller.addressController,
          "Address",
          icon: CupertinoIcons.home,
        ),
        const SizedBox(height: 8),
        _inputField(
          controller.noteController,
          "Notes",
          icon: CupertinoIcons.book,
        ),
        const Divider(),
        const Text(
          "Add Item",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _inputField(
          controller.itemNameController,
          "Item Name",
          icon: Icons.insert_drive_file_outlined,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _inputField(
                controller.quantityController,
                "Quantity",
                icon: Icons.inventory_2_outlined,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _dropdownField("Unit", controller.selectedUnit, [
                "Nos",
                "Piece",
                "Kg",
                "Ltr",
                "Pack",
              ]),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _inputField(
                controller.priceController,
                "Rate",
                icon: Icons.currency_rupee,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _inputField(
                controller.mrpController,
                "MRP (Optional)",
                icon: Icons.qr_code,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _dropdownField("GST", controller.gstPercent, [
                "0%",
                "5%",
                "12%",
                "18%",
                "28%",
              ]),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _inputField(
                controller.cessController,
                "CESS",
                icon: Icons.percent,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _inputField(
          controller.hsnController,
          "HSN Code (Optional)",
          icon: Icons.qr_code,
        ),
        const SizedBox(height: 12),
        Align(
          child: SizedBox(
            width: Get.width / 2,
            child: ElevatedButton(
              onPressed: controller.addItemToList,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                "Add Item",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ReviewTab extends GetView<MakeKhataBillsController> {
  const _ReviewTab();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView(
        padding: const EdgeInsets.all(12),
        children: [
          if (controller.billItems.isEmpty)
            const Center(child: Text("No items added yet")),
          if (controller.billItems.isNotEmpty) ...[
            const Text(
              "Added Items",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...controller.billItems.map(
              (item) => Card(
                child: ListTile(
                  title: Text(item.itemName ?? ""),
                  subtitle: Text(
                    "Qty: ${item.quantity} | Price: ₹${item.price} | GST: ${item.gstPercent}%",
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => controller.billItems.remove(item),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _totalsSection(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.submitBill,
              style: ElevatedButton.styleFrom(
                backgroundColor: Get.theme.primaryColor,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                "Submit Bill",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

Widget _totalsSection() {
  final c = Get.find<MakeKhataBillsController>();
  return Obx(
    () => Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _totalRow("Subtotal:", c.subtotal.toStringAsFixed(2)),
          _totalRow("GST:", c.gstAmount.toStringAsFixed(2)),
          _totalRow("CESS:", c.cessAmount.toStringAsFixed(2)),
          const Divider(),
          _totalRow(
            "Total:",
            c.totalBalance.value.toStringAsFixed(2),
            isBold: true,
            color:
                c.totalBalance.value < 0 ? Colors.red : Get.theme.primaryColor,
          ),
        ],
      ),
    ),
  );
}

Widget _totalRow(
  String label,
  String value, {
  bool isBold = false,
  Color? color,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        ),
      ),
      Text(
        "₹$value",
        style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          color: color,
        ),
      ),
    ],
  );
}

Widget _inputField(
  TextEditingController ctrl,
  String hint, {
  IconData? icon,
  TextInputType? keyboardType,
}) {
  return TextFormField(
    controller: ctrl,
    keyboardType: keyboardType,
    decoration: _fieldDecoration(hint, icon: icon),
  );
}

Widget _dropdownField(
  String hint,
  RxString selectedValue,
  List<String> options,
) {
  return Obx(
    () => DropdownButtonFormField<String>(
      value: selectedValue.value.isEmpty ? null : selectedValue.value,
      onChanged: (val) => selectedValue.value = val ?? "",
      items:
          options
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
      decoration: _fieldDecoration(hint),
    ),
  );
}

InputDecoration _fieldDecoration(String hint, {IconData? icon}) {
  return InputDecoration(
    hintText: hint,
    prefixIcon:
        icon != null
            ? Icon(icon, size: 20, color: Get.theme.primaryColor)
            : null,
    filled: true,
    fillColor: Get.theme.canvasColor,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
  );
}
