import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.handleBackPress,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        body: Obx(() => controller.getCurrentScreen()),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeTab,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedItemColor: Get.theme.primaryColor,
            unselectedItemColor: Get.theme.primaryColor.withOpacity(.4),
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            items: [
              _navItem(0, Iconsax.home, 'Home'),
              _navItem(1, Iconsax.category, 'Booking'),
              _navItem(2, Iconsax.settings, 'Setting'),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _navItem(int index, IconData icon, String label) {
    return BottomNavigationBarItem(
      label: label,
      icon: Obx(() {
        final isSelected = controller.selectedIndex.value == index;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder:
              (child, anim) => ScaleTransition(scale: anim, child: child),
          child: Icon(
            icon,
            key: ValueKey(isSelected),
            size: isSelected ? 28 : 24,
            color:
                isSelected
                    ? Get.theme.primaryColor
                    : Get.theme.primaryColor.withOpacity(.4),
          ),
        );
      }),
    );
  }
}
