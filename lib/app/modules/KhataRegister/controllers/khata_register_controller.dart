import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:servizo_vendor/app/Api/Api_Import.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Data/storage.dart';
import 'package:servizo_vendor/app/Model/common_model.dart';
import 'package:servizo_vendor/app/Model/khata_profile_resp.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KhataRegisterController extends GetxController {
  final khataProfileData = Rxn<KhataProfileData>();
  final khataProfileDataLoaded = false.obs;
  final prefs = Get.find<SharedPreferences>();
  final fullName = TextEditingController();
  final firmName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final address = TextEditingController();
  final gstNumber = TextEditingController();

  final isLoading = false.obs;

  final ApiImport apiImport = ApiImport();

  Future<void> registerUser() async {
    isLoading.value = true;
    final body = {
      "userID": userInfo?.userID ?? 0,
      "fullName": fullName.text,
      "firmName": firmName.text,
      "email": email.text,
      "phoneNumber": phoneNumber.text,
      "passwordHash": password.text,
      "address": address.text,
      "gstNumber": gstNumber.text,
    };

    ApiResponse apiResponse = await apiImport.registerKhatabookApi(body);

    isLoading.value = false;

    if (apiResponse.status) {
      CommonResponse response = apiResponse.data;
      getKhataUserProfile();
      customSnackBar(
        type: 1,
        status: "Success",
        message: response.message,
        positin: 1,
      );
    } else {
      customSnackBar(
        type: 0,
        status: "Failed",
        message: apiResponse.message.toString(),
        positin: 1,
      );
    }
  }

  Future<void> getKhataUserProfile() async {
    khataProfileDataLoaded.value = false;
    try {
      ApiResponse apiResponse = await apiImport.getKhataUserProfileApi(
        userInfo?.userID ?? 0,
      );
      if (apiResponse.status) {
        KhataProfileResp response = apiResponse.data;
        khataProfileData.value = response.data;
        khataProfileDataLoaded.value = true;

        Get.back();
        saveUserData(response.data);
      } else {
        khataProfileDataLoaded.value = true;
      }
    } catch (e) {
      khataProfileDataLoaded.value = true;
    }
  }

  Future<void> saveUserData(KhataProfileData userData) async {
    await prefs.setString(
      StorageConstants.isKhatabookRegister,
      jsonEncode(userData.toJson()),
    );
  }
}
