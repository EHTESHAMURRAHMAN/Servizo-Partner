import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Api/Api_Import.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Model/common_model.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/modules/KhataClients/controllers/khata_clients_controller.dart';

class AddKhataClientsController extends GetxController {
  final khataClientsController = Get.find<KhataClientsController>();
  final formKey = GlobalKey<FormState>();
  final ApiImport apiImport = ApiImport();
  final firmNameController = TextEditingController();
  final proprietorNameController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();
  final pinCodeController = TextEditingController();
  final gstinController = TextEditingController();

  void clearFields() {
    firmNameController.clear();
    proprietorNameController.clear();
    mobileController.clear();
    addressController.clear();
    pinCodeController.clear();
    gstinController.clear();
  }

  @override
  void onClose() {
    firmNameController.dispose();
    proprietorNameController.dispose();
    mobileController.dispose();
    addressController.dispose();
    pinCodeController.dispose();
    gstinController.dispose();
    super.onClose();
  }

  Future<void> addKhataClient() async {
    Map body = {
      "userId": userInfo?.userID ?? 0,
      "firmName": firmNameController.text.trim(),
      "proprieterName": proprietorNameController.text.trim(),
      "mobileNo": mobileController.text.trim(),
      "clientAddress": addressController.text.trim(),
      "pincode": pinCodeController.text.trim(),
      "gstin": gstinController.text.trim(),
    };
    ApiResponse apiResponse = await apiImport.addKhataClientApi(body);
    if (apiResponse.status) {
      CommonResponse response = apiResponse.data;

      Get.back();
      khataClientsController.getKhataClient();
      customSnackBar(type: 1, status: "Success", message: response.message);
    } else {
      customSnackBar(
        type: 0,
        status: "Error",
        message: apiResponse.message.toString(),
      );
    }
  }
}
