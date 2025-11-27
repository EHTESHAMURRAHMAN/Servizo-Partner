import 'package:get/get.dart';

import '../controllers/connect_with_u_s_controller.dart';

class ConnectWithUSBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectWithUSController>(
      () => ConnectWithUSController(),
    );
  }
}
