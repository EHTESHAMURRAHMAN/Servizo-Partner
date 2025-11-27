import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/modules/Vendor/VenderBooking/views/vender_booking_view.dart';
import 'package:servizo_vendor/app/modules/Vendor/VendorHome/views/vendor_home_view.dart';
import '../../VendorSetting/views/vendor_setting_view.dart';

class VendorDashboardController extends GetxController {
  var currentIndex = 0.obs;
  final PageController pageController = PageController();

  final List<Widget> pages = [
    const VendorHomeView(),
    const VenderBookingView(),
    const VendorSettingView(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
