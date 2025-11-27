import 'package:get/get.dart';
import 'package:servizo_vendor/app/modules/Vendor/VendorNotification/controllers/VendorNotificationController.dart';

class VendorNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorNotificationController>(
      () => VendorNotificationController(),
    );
  }
}
