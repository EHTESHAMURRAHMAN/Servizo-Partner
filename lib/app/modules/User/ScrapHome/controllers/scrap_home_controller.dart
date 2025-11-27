import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Api/api_import.dart';
import 'package:servizo_vendor/app/Model/picked_scrap_resp.dart';

class ScrapHomeController extends GetxController {
  var pickedScrapData = <PickedScrapData>[].obs;
  var isScrapLoading = false.obs;

  var currentIndex = 0.obs;
  PageController? pageController;

  @override
  void onInit() {
    super.onInit();
    pickupScrap();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController?.dispose();
    super.onClose();
  }

  void changePage(int index) {
    currentIndex.value = index;
    pageController?.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void nextPage(int length) {
    if (currentIndex.value < length - 1) changePage(currentIndex.value + 1);
  }

  void previousPage() {
    if (currentIndex.value > 0) changePage(currentIndex.value - 1);
  }

  final ApiImport apiImport = ApiImport();

  Future<void> pickupScrap() async {
    try {
      isScrapLoading.value = true;

      ApiResponse apiResponse = await apiImport.getPickedScrapApi(
        userInfo?.userID ?? 0,
      );

      if (apiResponse.status) {
        PickedScrapResp response = apiResponse.data;
        pickedScrapData.assignAll(response.data);
      } else {
        pickedScrapData.clear();
      }
    } catch (e) {
      pickedScrapData.clear();
      print("Error in pickupScrap: $e");
    } finally {
      isScrapLoading.value = false;
    }
  }
}
