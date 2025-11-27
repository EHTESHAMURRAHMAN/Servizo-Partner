import 'package:get/get.dart';
import 'package:servizo_vendor/app/modules/passwordRecovery/controllers/otpVerifyController.dart';

class OtpVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OtpVerifyController>(OtpVerifyController());
  }
}
