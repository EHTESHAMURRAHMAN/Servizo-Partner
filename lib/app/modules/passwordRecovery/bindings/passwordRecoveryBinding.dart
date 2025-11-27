import 'package:get/get.dart';
import 'package:servizo_vendor/app/modules/passwordRecovery/controllers/passwordRecoveryController.dart';

class PasswordRecoveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PasswordRecoveryController>(PasswordRecoveryController());
  }
}
