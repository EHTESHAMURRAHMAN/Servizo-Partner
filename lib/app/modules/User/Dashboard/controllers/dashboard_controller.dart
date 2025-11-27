import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/modules/User/MyBookings/controllers/my_bookings_controller.dart';
import 'package:servizo_vendor/app/modules/User/MyBookings/views/my_bookings_view.dart';
import 'package:servizo_vendor/app/modules/User/Setting/controllers/setting_controller.dart';
import 'package:servizo_vendor/app/modules/User/Setting/views/setting_view.dart';
import 'package:servizo_vendor/app/modules/User/home/controllers/home_controller.dart';
import 'package:servizo_vendor/app/modules/User/home/views/home_view.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  int counter = 0;

  @override
  void onInit() {
    super.onInit();
    _initController(0);
  }

  void changeTab(int index) {
    _disposeController(selectedIndex.value);
    _initController(index);
    selectedIndex.value = index;
  }

  void _initController(int index) {
    switch (index) {
      case 0:
        if (!Get.isRegistered<HomeController>()) {
          Get.put(HomeController());
        }
        break;
      case 1:
        if (!Get.isRegistered<MyBookingsController>()) {
          Get.put(MyBookingsController());
        }
        break;
      case 2:
        if (!Get.isRegistered<SettingController>()) {
          Get.put(SettingController());
        }
        break;
    }
  }

  void _disposeController(int index) {
    switch (index) {
      case 0:
        // if (Get.isRegistered<HomeController>()) {
        //   Get.delete<HomeController>();
        // }
        break;
      case 1:
        if (Get.isRegistered<MyBookingsController>()) {
          Get.delete<MyBookingsController>();
        }
        break;
      case 2:
        if (Get.isRegistered<SettingController>()) {
          Get.delete<SettingController>();
        }
        break;
    }
  }

  Widget getCurrentScreen() {
    switch (selectedIndex.value) {
      case 0:
        return const HomeView();
      case 1:
        return const MyBookingsView();
      case 2:
        return const SettingView();
      default:
        return const HomeView();
    }
  }

  Future<bool> handleBackPress() async {
    counter += 1;
    if (counter == 1) {
      EasyLoading.showToast('Press two times to Exit'.tr);
      Future.delayed(const Duration(seconds: 1), () {
        counter = 0;
      });
    }
    return counter >= 2;
  }
}
