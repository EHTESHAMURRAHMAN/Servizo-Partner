import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Api/api_import.dart';
import 'package:servizo_vendor/app/Model/common_model.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/modules/KhataBills/controllers/khata_bills_controller.dart';

class MakeKhataBillsController extends GetxController {
  final khataBillsController = Get.find<KhataBillsController>();
  final gstController = TextEditingController();
  final addressController = TextEditingController();
  final headingController = TextEditingController();
  final itemNameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final mrpController = TextEditingController();
  final cessController = TextEditingController();
  final hsnController = TextEditingController();
  final noteController = TextEditingController();
  final customerController = TextEditingController();
  var selected = RxnInt();
  var selectedUnit = "Nos".obs;
  var gstPercent = "".obs;
  var priceWithTax = "".obs;
  final billItems = RxList<BillItemModel>();
  final ApiImport apiImport = ApiImport();

  final argument = Get.arguments;
  final clientID = 0.obs;
  var totalBalance = 0.0.obs;

  final isPaid = 0.obs;
  @override
  void onInit() {
    super.onInit();
    if (argument != null) {
      clientID.value = argument['ClientId'] ?? 0;
      customerController.text = argument['CustomerName'] ?? "";
    }

    quantityController.addListener(_updateTotal);
    priceController.addListener(_updateTotal);
    gstPercent.listen((_) => _updateTotal());
    cessController.addListener(_updateTotal);
  }

  double get subtotal {
    final qty = int.tryParse(quantityController.text) ?? 0;
    final rate = double.tryParse(priceController.text) ?? 0.0;
    return qty * rate;
  }

  double get gstAmount {
    final gst = int.tryParse(gstPercent.value.replaceAll("%", "")) ?? 0;
    return subtotal * (gst / 100);
  }

  double get cessAmount {
    final cess = double.tryParse(cessController.text) ?? 0;
    return subtotal * (cess / 100);
  }

  double get totalTax => gstAmount + cessAmount;

  void _updateTotal() {
    totalBalance.value = calculateTotal();
  }

  double calculateTotal() {
    final quantity = int.tryParse(quantityController.text) ?? 0;
    final price = double.tryParse(priceController.text) ?? 0;
    final gst = int.tryParse(gstPercent.value.replaceAll("%", "")) ?? 0;
    final cess = double.tryParse(cessController.text) ?? 0;

    final subtotal = price * quantity;

    final gstAmount = subtotal * (gst / 100);
    final cessAmount = subtotal * (cess / 100);

    return subtotal + gstAmount + cessAmount;
  }

  void addItemToList() {
    final qty = int.tryParse(quantityController.text) ?? 0;
    final price = double.tryParse(priceController.text) ?? 0;
    final gst = int.tryParse(gstPercent.value.replaceAll("%", "")) ?? 0;
    final cess = double.tryParse(cessController.text) ?? 0;

    final subtotal = qty * price;
    final gstAmount = subtotal * gst / 100;
    final cessAmount = subtotal * cess / 100;

    final item = BillItemModel(
      itemId: 0,
      billId: 0,
      itemName: itemNameController.text,
      quantity: qty,
      productType: selectedUnit.value,
      mrp: double.tryParse(mrpController.text) ?? 0,
      price: price,
      gstPercent: gst,
      priceWithTax: subtotal + gstAmount + cessAmount,
      cessPercent: cess,
      hsn: hsnController.text,
    );

    billItems.add(item);

    // Clear inputs after adding
    itemNameController.clear();
    quantityController.clear();
    priceController.clear();
    mrpController.clear();
    cessController.clear();
    hsnController.clear();
    gstPercent.value = "";
    priceWithTax.value = "";
  }

  void submitBill() async {
    final total = calculateTotal();

    // Convert billItems list into JSON-compatible maps
    final items =
        billItems.map((item) {
          return {
            "itemId": item.itemId ?? 0,
            "billId": item.billId ?? 0,
            "itemName": item.itemName ?? "",
            "quantity": item.quantity ?? 0,
            "productType": item.productType ?? "",
            "mrp": item.mrp ?? 0,
            "price": item.price ?? 0,
            "gstPercent": item.gstPercent ?? 0,
            "priceWithTax": item.priceWithTax ?? 0,
            "cessPercent": item.cessPercent ?? 0,
            "hsn": item.hsn ?? "",
          };
        }).toList();

    final body = {
      "createdAt": "2025-09-16T10:30:00",
      "userid": userInfo?.userID ?? 0,
      "customerName": customerController.text,
      "clientId": clientID.value,
      "note": noteController.text,
      "isPaid": true,
      "gstid": gstController.text,
      "address": addressController.text,
      "heading": headingController.text,
      "items": items,
      "total": total,
    };

    ApiResponse apiResponse = await apiImport.addKhataBillsApi(body);

    if (apiResponse.status) {
      CommonResponse response = apiResponse.data;
      khataBillsController.getKhataBills();

      Get.back();
      if (clientID.value != 0) Get.back();

      customSnackBar(
        type: 1,
        positin: 0,
        status: "Success",
        message: response.message,
      );
    } else {
      customSnackBar(
        type: 0,
        positin: 0,
        status: "Failed",
        message: apiResponse.message.toString(),
      );
    }
  }

  void updateBillPayStatus({int? billId, int? status}) async {
    final body = {"billId": billId, "isPaid": status};

    ApiResponse apiResponse = await apiImport.updateBillPayStatusAPi(body);

    if (apiResponse.status) {
      khataBillsController.getKhataBills();
      Get.back();
    } else {
      customSnackBar(
        type: 0,
        positin: 0,
        status: "Failed",
        message: apiResponse.message.toString(),
      );
    }
  }
}

class BillItemModel {
  int? itemId;
  int? billId;
  String? itemName;
  int? quantity;
  String? productType;
  double? mrp;
  double? price;
  int? gstPercent;
  dynamic priceWithTax;
  double? cessPercent;
  String? hsn;

  BillItemModel({
    this.itemId,
    this.billId,
    this.itemName,
    this.quantity,
    this.productType,
    this.mrp,
    this.price,
    this.gstPercent,
    this.priceWithTax,
    this.cessPercent,
    this.hsn,
  });
}
