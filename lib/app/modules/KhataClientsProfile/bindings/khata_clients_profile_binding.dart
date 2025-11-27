import 'package:get/get.dart';

import '../controllers/khata_clients_profile_controller.dart';

class KhataClientsProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KhataClientsProfileController>(
      () => KhataClientsProfileController(),
    );
  }
}
