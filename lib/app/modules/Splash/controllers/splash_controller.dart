import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:servizo_vendor/app/Data/storage.dart';
import 'package:servizo_vendor/app/Model/Profile_response.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final SharedPreferences prefs = Get.find<SharedPreferences>();
  Rx<Position?> currentPosition = Rx<Position?>(null);
  RxString street = ''.obs;
  RxString locality = ''.obs;
  RxString country = ''.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _launchApp();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        errorMessage.value = 'Location services are disabled.';
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          errorMessage.value = 'Location permission denied.';
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        errorMessage.value =
            'Location permission denied forever. Please enable it in settings.';
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentPosition.value = position;
      errorMessage.value = '';

      await getAddressFromCoordinates(position);
    } catch (e) {
      errorMessage.value = 'Failed to get location: $e';
    }
  }

  Future<void> getAddressFromCoordinates(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        street.value =
            '${place.subLocality}'
            '${place.subAdministrativeArea}';
        locality.value =
            '${place.locality}, ${place.postalCode}, ${place.country}';
        country.value = '${place.postalCode}, ${place.country}';
        await prefs.setString(StorageConstants.street, street.value);
        await prefs.setString(StorageConstants.locality, locality.value);
        await prefs.setString(StorageConstants.country, country.value);
      } else {
        street.value = 'No street found';
        locality.value = 'No locality found';
        country.value = 'No country found';
      }
    } catch (e) {
      street.value = 'Failed to get street: $e';
      locality.value = 'Failed to get locality: $e';
      country.value = 'Failed to get country: $e';
    }
  }

  void _launchApp() async {
    await Future.delayed(const Duration(seconds: 2));

    bool isLogin = prefs.getBool(StorageConstants.isLogin) ?? false;
    bool isVender = prefs.getBool(StorageConstants.loginAsVender) ?? false;

    String? storedData = prefs.getString(StorageConstants.userInfo);

    if (storedData == null || storedData.isEmpty) {
      Get.offAllNamed(Routes.ONBOARD);
      return;
    }

    try {
      List<ProfileData> users = List<ProfileData>.from(
        jsonDecode(storedData).map((x) => ProfileData.fromJson(x)),
      );

      if (users.isNotEmpty) {
        ProfileData activeUser = users.first;
        userInfo = activeUser;
      }
      if (isVender) {
        Get.offAllNamed(Routes.VENDOR_DASHBOARD);
      } else if (isLogin) {
        Get.offAllNamed(Routes.DASHBOARD);
      } else if (!isLogin || !isVender) {
        Get.offAllNamed(Routes.ONBOARD);
        return;
      }
    } catch (e) {
      print("Error parsing user data: $e");
      Get.offAllNamed(Routes.ONBOARD);
    }
  }
}
