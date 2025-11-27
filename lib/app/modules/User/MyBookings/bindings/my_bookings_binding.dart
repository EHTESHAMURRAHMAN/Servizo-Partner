import 'package:get/get.dart';

import '../controllers/my_bookings_controller.dart';

class MyBookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MyBookingsController>(MyBookingsController());
  }
}
