import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:servizo_vendor/app/Api/api_import.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Model/CategoryResp.dart';
import 'package:servizo_vendor/app/Model/subCategoryResp.dart';
import 'package:servizo_vendor/app/modules/User/home/controllers/home_controller.dart';

class CategorysController extends GetxController {
  final homeController = Get.find<HomeController>();
  final ApiImport apiImpl = ApiImport();
  final categoryList = <CategoryData>[].obs;
  final isCatLoad = false.obs;
  final subCategoryList = <SubcategoryData>[].obs;
  final isSubCatLoad = false.obs;
  final selectedCategoryId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getCategory();
  }

  Future<void> getCategory() async {
    isCatLoad.value = true;
    ApiResponse apiResponse = await apiImpl.getCategoryApi();
    if (apiResponse.status) {
      CategoryResp response = apiResponse.data;
      categoryList.value = response.data;
      if (categoryList.isNotEmpty) {
        selectCategory(categoryList.first.categoryId);
      }
    } else {
      EasyLoading.showToast(apiResponse.message.toString());
    }
    isCatLoad.value = false;
  }

  Future<void> getSubCategory(int categoryId) async {
    isSubCatLoad.value = false;
    ApiResponse apiResponse = await apiImpl.getSubCategoryApi(categoryId);
    if (apiResponse.status) {
      SubcategoryResp response = apiResponse.data;
      subCategoryList.value = response.data;
    } else {
      EasyLoading.showToast(apiResponse.message.toString());
    }
    isSubCatLoad.value = true;
  }

  void selectCategory(int categoryId) {
    if (selectedCategoryId.value != categoryId) {
      selectedCategoryId.value = categoryId;
      getSubCategory(categoryId);
      update();
    }
  }
}
