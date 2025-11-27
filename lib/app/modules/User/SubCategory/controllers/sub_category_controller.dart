import 'package:get/get.dart';
import 'package:servizo_vendor/app/modules/User/home/controllers/home_controller.dart';
import 'package:servizo_vendor/app/Api/api_import.dart';

class SubCategoryController extends GetxController {
  ApiImport apiImpl = ApiImport();
  final homeController = Get.find<HomeController>();
}
