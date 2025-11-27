import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Api/api_import.dart';

class PasswordRecoveryController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  late final String userType;
  ApiImport apiImpl = ApiImport();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userType = Get.arguments['userType'];
  }

  // Future<void> recoverPassword() async {
  //   if (formKey.currentState!.validate()) {
  //     Map body = {'userType': userType, 'email': emailController.text.trim()};
  //     ApiResponse apiResponse = await apiImpl.recoverPasswordApi(body);
  //     if (!apiResponse.status) {
  //       EasyLoading.showToast(apiResponse.message.toString());
  //       Get.toNamed(
  //         "/otpVerify",
  //         arguments: {
  //           'userType': userType,
  //           'email': emailController.text.trim(),
  //         },
  //       );
  //     } else {
  //       // EasyLoading.showToast(apiResponse.message.toString());
  //       showDialog(emailController.text.trim(), userType);
  //     }
  //   }
  // }
}

void showDialog(String email, String userType) {
  Get.dialog(
    AlertDialog(
      title: Text('Alert'),
      content: Text('You are not registered as $userType'),
      actions: [TextButton(child: Text("Close"), onPressed: () => Get.back())],
    ),
  );
}
