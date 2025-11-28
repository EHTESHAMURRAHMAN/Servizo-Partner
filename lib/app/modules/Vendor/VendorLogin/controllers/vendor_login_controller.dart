import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Api/api_import.dart';
import 'package:servizo_vendor/app/Data/storage.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Api/Base_Api.dart';
import '../../../../Model/AuthResp.dart';
import '../../../../Model/Profile_response.dart';

class VendorLoginController extends GetxController {
  final prefs = Get.find<SharedPreferences>();
  final controllerlogin = TextEditingController();
  final controllerPassword = TextEditingController();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  ApiImport apiImpl = ApiImport();

  Future<void> login() async {
    final FormState? form = loginFormKey.currentState;
    if (form?.validate() ?? false) {
      Map body = {
        "login": controllerlogin.text,
        "pass_hash": controllerPassword.text,
      };
      ApiResponse apiResponse = await apiImpl.signinApi(body);

      if (apiResponse.status) {
        AuthResp response = apiResponse.data;
        customSnackBar(
          positin: 1,
          type: 1,
          status: "Success",
          message: response.message,
        );

        getProfile(response.data.userID);
      } else {
        customSnackBar(
          positin: 1,
          type: 0,
          status: "Failed",
          message: apiResponse.message.toString(),
        );
      }
    }
  }

  Future<void> getProfile(int id) async {
    try {
      ApiResponse apiResponse = await apiImpl.getProfileApi(id);
      if (apiResponse.status) {
        ProfileResp response = apiResponse.data;
        if (response.data?.role == "Vendor") {
          prefs.setBool(StorageConstants.isLogin, false);
          Get.toNamed(Routes.VENDOR_DASHBOARD);
        } else {
          debugPrint(response.message.toString());
        }
      } else {
        debugPrint(apiResponse.message.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
