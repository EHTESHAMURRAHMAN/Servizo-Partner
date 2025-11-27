import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Api/api_import.dart';

class PasswordResetController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  late final String email;
  ApiImport apiImpl = ApiImport();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    email = Get.arguments['email'];
  }

  // void resetPassword() async {
  //   if (formKey.currentState!.validate()) {
  //     if (passwordController1.text == passwordController2.text) {
  //       {
  //         Map body = {
  //           'password': passwordController1.text.trim(),
  //           'email': email,
  //         };
  //         ApiResponse apiResponse = await apiImpl.resetPasswordApi(body);
  //         if (apiResponse.status) {
  //           EasyLoading.showToast(apiResponse.message.toString());
  //           Get.toNamed("/login");
  //         } else {
  //           EasyLoading.showToast(apiResponse.message.toString());
  //         }
  //       }
  //     } else {
  //       // Get.showSnackbar(GetSnackBar(title: "password is not equal"));
  //       showDialog();
  //     }
  //   }
  // }

  void showDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Alert'),
        content: Text("Passwords didn't match"),
        actions: [
          TextButton(child: Text("Close"), onPressed: () => Get.back()),
        ],
      ),
    );
  }
}
