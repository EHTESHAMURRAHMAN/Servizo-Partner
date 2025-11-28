import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:servizo_vendor/app/Api/api_import.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Data/storage.dart';
import 'package:servizo_vendor/app/Model/AuthResp.dart';
import 'package:servizo_vendor/app/Model/Profile_response.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VendorRegisterController extends GetxController {
  final prefs = Get.find<SharedPreferences>();
  final controllerName = TextEditingController();
  final controllerMobile = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerAddress = TextEditingController();

  final GlobalKey<FormState> regiFormKey = GlobalKey<FormState>();
  ApiImport apiImpl = ApiImport();

  Future<void> register() async {
    final FormState? form = regiFormKey.currentState;
    if (form?.validate() ?? false) {
      Map body = {
        "name": controllerName.text,
        "phone": controllerMobile.text,
        "email": controllerEmail.text,
        "pass_Hash": controllerPassword.text,
        "address": controllerAddress.text,
        "role": "Vendor",
      };
      ApiResponse apiResponse = await apiImpl.signUpApi(body);

      if (apiResponse.status) {
        AuthResp response = apiResponse.data;
        EasyLoading.showToast(response.message);
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
