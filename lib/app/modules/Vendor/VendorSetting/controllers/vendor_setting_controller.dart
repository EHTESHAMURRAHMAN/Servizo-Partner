import 'package:get/get.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class VendorSettingController extends GetxController {
  final RxBool isDarkMode = Get.isDarkMode.obs;
  final RxBool enableNotifications = true.obs;
  final RxString selectedLanguage = 'English'.obs;
  late SharedPreferences prefs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? Get.isDarkMode;
    enableNotifications.value = prefs.getBool('notifications') ?? true;
    selectedLanguage.value = prefs.getString('language') ?? 'English';
  }

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
    prefs.setBool('isDarkMode', value);
  }

  void toggleNotifications(bool value) {
    enableNotifications.value = value;
    prefs.setBool('notifications', value);
    Get.snackbar('Notifications', value ? 'Enabled' : 'Disabled');
    // Add FCM or notification logic here if needed
  }

  void changeLanguage(String value) {
    selectedLanguage.value = value;
    prefs.setString('language', value);
    Get.snackbar('Language', 'Changed to $value');
    // Add localization logic here (e.g., Get.updateLocale)
  }

  Future<void> logout() async {
    await prefs.clear();
    await Get.delete();
    Get.offAllNamed(Routes.ONBOARD);
    Get.snackbar('Logout', 'You have been logged out successfully.');
  }
}
