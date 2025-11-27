import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Data/storage.dart';
import 'package:servizo_vendor/app/Model/CategoryResp.dart';
import 'package:servizo_vendor/app/Model/khata_profile_resp.dart';
import 'package:servizo_vendor/app/Model/subCategoryResp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Api/api_import.dart';
import '../../../../Model/VendersResp.dart';

class HomeController extends GetxController {
  final khataProfileData = Rxn<KhataProfileData>();
  final khataProfileDataLoaded = false.obs;
  double padding = 15.0;
  final prefs = Get.find<SharedPreferences>();
  final categoryList = RxList<CategoryData>();
  final isCatLoad = false.obs;
  final subCategoryList = RxList<SubcategoryData>();
  final isSubCatLoad = false.obs;
  final venderlist = RxList<VendorData>();
  final isVendersLoad = false.obs;
  final fullcat = false.obs;
  final catName = "".obs;
  final getStreet = "".obs;
  final getLocality = "".obs;
  final getCountry = "".obs;

  //
  Rx<Position?> currentPosition = Rx<Position?>(null);
  RxString street = ''.obs;
  RxString locality = ''.obs;
  RxString country = ''.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getCategory();
    getCurrentLocation();
    getKhataUserProfile();
    // getStreet.value = prefs.getString(StorageConstants.street) ?? '';
    // getLocality.value = prefs.getString(StorageConstants.locality) ?? '';
    // getCountry.value = prefs.getString(StorageConstants.country) ?? '';
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
        street.value = '${place.street}';
        locality.value =
            '${place.name}, ${place.subLocality}, ${place.locality}';
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

  ApiImport apiImpl = ApiImport();

  Future<void> getCategory() async {
    ApiResponse apiResponse = await apiImpl.getCategoryApi();

    if (apiResponse.status) {
      CategoryResp response = apiResponse.data;
      categoryList.value = response.data;
    } else {
      EasyLoading.showToast(apiResponse.message.toString());
    }
  }

  Future<void> getSubCategory(int id) async {
    isSubCatLoad.value = false;
    ApiResponse apiResponse = await apiImpl.getSubCategoryApi(id);
    if (apiResponse.status) {
      SubcategoryResp response = apiResponse.data;
      subCategoryList.value = response.data;
      isSubCatLoad.value = true;
    } else {
      EasyLoading.showToast(apiResponse.message.toString());
    }
  }

  Future<void> getVenders(int id) async {
    isVendersLoad.value = false;
    ApiResponse apiResponse = await apiImpl.getVendersApi(id);
    if (apiResponse.status) {
      VendersResp response = apiResponse.data;
      venderlist.value = response.data;
      isVendersLoad.value = true;
    } else {
      EasyLoading.showToast(apiResponse.message.toString());
    }
  }

  Future<void> getKhataUserProfile() async {
    khataProfileDataLoaded.value = false;
    try {
      ApiResponse apiResponse = await apiImpl.getKhataUserProfileApi(
        userInfo?.userID ?? 0,
      );
      if (apiResponse.status) {
        KhataProfileResp response = apiResponse.data;
        khataProfileData.value = response.data;
        khataProfileDataLoaded.value = true;

        // Get.back();
      } else {
        khataProfileDataLoaded.value = true;
      }
    } catch (e) {
      khataProfileDataLoaded.value = true;
    }
  }

  final List<Map<String, String>> govtServices = [
    {
      "name": "Passport Apply",
      "icon":
          "https://cdn-icons-png.freepik.com/256/620/620765.png?uid=R83311258&ga=GA1.1.1982983006.1742038592&semt=ais_hybrid",
      "url": "https://www.passportindia.gov.in/",
    },
    {
      "name": "Aadhaar Update",
      "icon": "https://cdn-icons-png.flaticon.com/128/10828/10828847.png",
      "url": "https://uidai.gov.in/",
    },
    {
      "name": "PAN Card",
      "icon": "https://cdn-icons-png.flaticon.com/128/2544/2544085.png",
      "url":
          "https://www.onlineservices.nsdl.com/paam/endUserRegisterContact.html",
    },
    {
      "name": "Driving License",
      "icon":
          "https://cdn-icons-png.freepik.com/256/9877/9877506.png?uid=R83311258&ga=GA1.1.1982983006.1742038592&semt=ais_hybrid",
      "url": "https://parivahan.gov.in/",
    },
    {
      "name": "Voter ID",
      "icon": "https://cdn-icons-png.flaticon.com/128/7444/7444382.png",
      "url": "https://www.nvsp.in/",
    },
    {
      "name": "Income Tax",
      "icon": "https://cdn-icons-png.flaticon.com/128/1651/1651909.png",
      "url": "https://www.incometax.gov.in/",
    },
  ];
}
