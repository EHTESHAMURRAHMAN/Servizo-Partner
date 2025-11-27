import 'package:get/get.dart';
import 'AppController.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put<AppController>(AppController(), permanent: true);
  }
}
