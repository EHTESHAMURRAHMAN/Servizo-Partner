import 'package:get/get.dart';

import '../controllers/scrap_booking_controller.dart';

class ScrapBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScrapBookingController>(
      () => ScrapBookingController(),
    );
  }
}
