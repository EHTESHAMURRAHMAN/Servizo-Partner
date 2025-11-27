import 'package:get/get.dart';

import '../controllers/vender_booking_controller.dart';

class VenderBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<VenderBookingController>(VenderBookingController());
  }
}
