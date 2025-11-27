import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servizo_vendor/app/Api/api_import.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Model/CategoryResp.dart';
import 'package:servizo_vendor/app/Model/VenderServiceResp.dart';
import 'package:servizo_vendor/app/Model/subCategoryResp.dart';
import 'package:servizo_vendor/app/modules/Vendor/VendorHome/controllers/vendor_home_controller.dart';
import 'package:servizo_vendor/main.dart';

import '../../../../Model/upload_resp.dart';

class AddVenderServiceController extends GetxController {
  final vendorHomeController = Get.find<VendorHomeController>();
  final categoryList = <CategoryData>[].obs;
  final formKey = GlobalKey<FormState>();

  final isCatLoad = false.obs;
  final subCategoryList = <SubcategoryData>[].obs;
  final isSubCatLoad = false.obs;
  ApiImport apiImpl = ApiImport();

  final selectCategoryID = 0.obs;
  final selectSubCategoryID = 0.obs;
  final selectCategoryName = 0.obs;
  final selectSubCategoryName = 0.obs;
  final serviceIMG = Rxn<XFile>();
  final serviceIMGURL = Rxn<String>();
  var serviceCharge = 0.0.obs;
  final argument = Get.arguments;

  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getCategory();
  }

  Future<void> getCategory() async {
    isCatLoad.value = false;
    ApiResponse apiResponse = await apiImpl.getCategoryApi();
    if (apiResponse.status) {
      CategoryResp response = apiResponse.data;
      categoryList.value = response.data;
      isCatLoad.value = true;
    } else {
      EasyLoading.showToast(apiResponse.message.toString());
    }
    isCatLoad.value = false;
  }

  Future<void> getSubCategory(int categoryId) async {
    isSubCatLoad.value = false;
    ApiResponse apiResponse = await apiImpl.getSubCategoryApi(categoryId);
    if (apiResponse.status) {
      SubcategoryResp response = apiResponse.data;
      subCategoryList.value = response.data;
      isSubCatLoad.value = true;
    } else {
      EasyLoading.showToast(apiResponse.message.toString());
    }
  }

  Future<void> addVendorService() async {
    if (formKey.currentState!.validate()) {
      Map body = {
        "vendorId": userInfo!.userID,
        "categoryId": selectCategoryID.value,
        "subcategoryId": 1,
        "description": description.text,
        "serviceImage": serviceIMGURL.value,
        'price': double.parse(price.text),
      };
      ApiResponse apiResponse = await apiImpl.addVendorServiceApi(body);
      if (apiResponse.status) {
        vendorHomeController.getVendorList();
        VendorServiceResp resp = apiResponse.data;
        EasyLoading.showToast(resp.message);
        Get.back();
      } else {
        EasyLoading.showToast(
          apiResponse.message ?? 'Error cancelling booking',
        );
      }
    }
  }

  Future<List?> uploadImage(context, {type = 0}) async {
    final ImagePicker picker = ImagePicker();
    if (!kIsWeb) {
      isLocalAuth = false;
    }

    if (type == 0) {
      await showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Take Image from'.tr),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('Gallery'.tr),
                    onTap: () {
                      type = 0;
                      Get.back();
                    },
                  ),
                  ListTile(
                    title: Text('Camera'.tr),
                    onTap: () {
                      type = 1;
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
      );
    }

    final XFile? image = await picker.pickImage(
      source: type == 0 ? ImageSource.gallery : ImageSource.camera,
    );

    if (image != null) {
      final File imageFile = File(image.path);
      final int imageSize = await imageFile.length();

      if (imageSize > 2 * 1024 * 1024) {
        EasyLoading.showToast('Image size should not exceed 2 MB'.tr);
        return null;
      }
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 90,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(title: 'Crop Image'),
          WebUiSettings(context: context),
        ],
      );

      if (croppedFile != null) {
        final File croppedImageFile = File(croppedFile.path);
        final Uint8List compressedBytes = await _compressImage(
          croppedImageFile,
          200 * 1024,
        );

        String base64Image = base64Encode(compressedBytes);
        Map body = {'DocBase64': base64Image};
        ApiResponse apiResponse = await apiImpl.uploadImageApi(body);

        if (apiResponse.status) {
          UploadResponse response = apiResponse.data;
          return [croppedFile.path, response.requestnumber];
        } else {
          EasyLoading.showToast('Failed'.tr);
        }
      }
    }
    return null;
  }

  Future<Uint8List> _compressImage(File file, int targetSizeInBytes) async {
    final Uint8List imageBytes = await file.readAsBytes();
    int quality = 100;
    Uint8List compressedBytes = imageBytes;

    while (compressedBytes.length > targetSizeInBytes && quality > 10) {
      compressedBytes = await FlutterImageCompress.compressWithList(
        imageBytes,
        quality: quality,
      );
      quality -= 10;
    }

    return compressedBytes;
  }
}
