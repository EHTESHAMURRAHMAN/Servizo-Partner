import 'package:get/get.dart';
import 'package:servizo_vendor/app/modules/User/home/controllers/home_controller.dart';
import '../../MyBookings/controllers/my_bookings_controller.dart';
import '../../Setting/controllers/setting_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(DashboardController());
    Get.put<HomeController>(HomeController());
    Get.put<MyBookingsController>(MyBookingsController());
    Get.put<SettingController>(SettingController());
  }
}
