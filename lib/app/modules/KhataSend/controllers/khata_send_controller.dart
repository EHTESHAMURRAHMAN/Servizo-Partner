import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Api/api_import.dart';
import 'package:servizo_vendor/app/Model/common_model.dart';
import 'package:servizo_vendor/app/Model/khata_client_resp.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/modules/KhataClients/controllers/khata_clients_controller.dart';
import 'package:servizo_vendor/app/modules/KhataClientsProfile/controllers/khata_clients_profile_controller.dart';

class KhataSendController extends GetxController {
  final khataClientsController = Get.find<KhataClientsController>();
  final clientsProfileCtrl = Get.find<KhataClientsProfileController>();
  final khataClientData = Rxn<KhataClientData>();
  final argument = Get.arguments;
  final ApiImport apiImport = ApiImport();

  @override
  void onInit() {
    super.onInit();
    if (argument != null) {
      khataClientData.value = argument['khataClientData'] ?? KhataClientData;
    }
  }

  final amountController = TextEditingController();
  final noteController = TextEditingController();
  final showNote = "".obs;
  Future<void> addClientTransaction() async {
    Map body = {
      "clientId": khataClientData.value?.id ?? 0,
      "userId": userInfo?.userID ?? 0,
      "transactionType": "Send",
      "amount": amountController.text,
      "description": noteController.text,
    };
    ApiResponse apiResponse = await apiImport.addClientTransactionApi(body);
    if (apiResponse.status) {
      CommonResponse response = apiResponse.data;

      Get.back();
      clientsProfileCtrl.getKhataClient();
      khataClientsController.getKhataClient();
      await SuccessDialog.show(
        Get.context!,
        message: response.message,
        lottieAsset: 'assets/animations/success.json',
      );
    } else {
      customSnackBar(
        type: 0,
        status: 'Failed',
        message: apiResponse.message.toString(),
      );
    }
  }
}

class SuccessDialog {
  static Future<void> show(
    BuildContext context, {
    String message = 'Success!',
    String lottieAsset = 'assets/animations/success.json',
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        AnimationController? controller;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Get.theme.canvasColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Lottie.asset(
                      lottieAsset,
                      controller: controller,
                      onLoaded: (composition) {
                        controller ??= AnimationController(
                          vsync: Navigator.of(context),
                          duration: Duration(milliseconds: 1000),
                        );
                        controller!.forward();
                        controller!.addStatusListener((status) {
                          if (status == AnimationStatus.completed) {
                            Get.back();
                            controller!.dispose();
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
