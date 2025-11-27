import 'package:get/get.dart';
import 'package:servizo_vendor/app/modules/Vendor/VenderBooking/controllers/vender_booking_controller.dart';
import 'package:servizo_vendor/app/modules/Vendor/VendorHome/controllers/vendor_home_controller.dart';

import '../../VendorSetting/controllers/vendor_setting_controller.dart';
import '../controllers/vendor_dashboard_controller.dart';

class VendorDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<VendorDashboardController>(VendorDashboardController());
    Get.put<VendorHomeController>(VendorHomeController());
    Get.put<VenderBookingController>(VenderBookingController());
    Get.put<VendorSettingController>(VendorSettingController());
  }
}
