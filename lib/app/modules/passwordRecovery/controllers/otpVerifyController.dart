import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Api/api_import.dart';

class OtpVerifyController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController otpController = TextEditingController();
  ApiImport apiImpl = ApiImport();

  // get the email from server  also get the email from previous screen
  late String email = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    email = Get.arguments['email'];
  }

  Future<void> verifyOtp() async {
    resetPassword();
    // if (formKey.currentState!.validate()) {
    //   Map body = {'otp': otpController.text.trim(), 'email': email};
    //   ApiResponse apiResponse = await apiImpl.verifyOtpApi(body);
    //   if (apiResponse.status) {
    //     EasyLoading.showToast(apiResponse.message.toString());
    //     resetPassword();
    //   } else {
    //     // EasyLoading.showToast(apiResponse.message.toString());
    //     showDialog();
    //   }
    // }
  }

  void resetPassword() {
    Get.toNamed("/passwordReset", arguments: {'email': email});
  }

  void resendOtp() {
    // ask server to resend otp in the same email
  }

  void showDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Alert'),
        content: Text("OTP didn't match with your email"),

        actions: [TextButton(child: Text("Back"), onPressed: () => Get.back())],
      ),
    );
  }
}
