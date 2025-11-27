import 'package:get/get.dart';
import 'package:servizo_vendor/app/modules/passwordRecovery/controllers/passwordResetController.dart';

class PasswordResetBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PasswordResetController>(PasswordResetController());
  }
}
