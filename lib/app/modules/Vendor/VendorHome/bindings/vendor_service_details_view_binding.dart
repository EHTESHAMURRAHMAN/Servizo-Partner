import 'package:get/get.dart';
import 'package:servizo_vendor/app/modules/Vendor/VendorHome/controllers/vendor_service_details_controller.dart';

class VendorServiceDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<VendorServiceDetailsController>(VendorServiceDetailsController());
  }
}
