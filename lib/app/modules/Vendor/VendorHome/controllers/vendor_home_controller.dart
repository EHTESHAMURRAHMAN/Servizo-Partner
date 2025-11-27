import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Api/api_import.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Model/CategoryResp.dart';
import 'package:servizo_vendor/app/Model/VendorList_resp.dart';
import 'package:servizo_vendor/app/Model/subCategoryResp.dart';

class VendorHomeController extends GetxController {
  final isSubCatLoad = false.obs;
  final isCatLoad = false.obs;
  final categoryList = <CategoryData>[].obs;
  final subCategoryList = <SubcategoryData>[].obs;

  ApiImport apiImpl = ApiImport();
  final vendorList = RxList<VendorList>();
  final isVendorList = false.obs;
  ApiImport apiImport = ApiImport();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getCategory();
    getVendorList();
  }

  Future<void> getVendorList() async {
    isVendorList.value = false;
    ApiResponse apiResponse = await apiImport.getVendorListApi(
      userInfo?.userID ?? 0,
    );
    if (apiResponse.status) {
      VendorListResp response = apiResponse.data;
      vendorList.value = response.data;
      isVendorList.value = true;
    }
  }

  Future<void> getCategory() async {
    isCatLoad.value = false;
    ApiResponse apiResponse = await apiImpl.getCategoryApi();
    if (apiResponse.status) {
      CategoryResp response = apiResponse.data;
      categoryList.value = response.data;
      isCatLoad.value = true;
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
      isSubCatLoad.value = true;
    } else {
      EasyLoading.showToast(apiResponse.message.toString());
    }
  }
}
