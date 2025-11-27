import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/vendor_dashboard_controller.dart';

class VendorDashboardView extends GetView<VendorDashboardController> {
  const VendorDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.currentIndex.value = index;
        },
        children: controller.pages,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          items: [
            _buildAnimatedNavItem(0, "assets/icons/home.png", context),
            _buildAnimatedNavItem(1, "assets/icons/booking.png", context),
            _buildAnimatedNavItem(2, "assets/icons/setting.png", context),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildAnimatedNavItem(
    int index,
    String image,
    context,
  ) {
    return BottomNavigationBarItem(
      icon: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOutBack,
          width: controller.currentIndex.value == index ? 30 : 24,
          height: controller.currentIndex.value == index ? 30 : 24,
          child: Image.asset(
            image,
            height: controller.currentIndex.value == index ? 30 : 24,
            color:
                controller.currentIndex.value == index
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
          ),
        ),
      ),
      label: "",
    );
  }
}
