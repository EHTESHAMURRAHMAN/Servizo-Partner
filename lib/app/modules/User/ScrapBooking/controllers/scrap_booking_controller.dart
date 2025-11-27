import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Api/api_import.dart';
import 'package:servizo_vendor/app/Model/common_model.dart';
import 'package:servizo_vendor/app/Model/upload_resp.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/modules/User/ScrapHome/controllers/scrap_home_controller.dart';
import 'package:servizo_vendor/main.dart';

class ScrapBookingController extends GetxController {
  final scrapHome = Get.find<ScrapHomeController>();
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final dateController = TextEditingController();

  final RxList<ScrapItem> items = <ScrapItem>[].obs;
  int _itemCounter = 1;

  final List<String> scrapTypes = [
    "Plastic",
    "Metal",
    "Paper",
    "Electronics",
    "Others",
  ];
  final RxString selectedScrapType = "".obs;
  final ApiImport apiImport = ApiImport();

  void pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (pickedDate != null) {
      dateController.text = pickedDate.toIso8601String();
    }
  }

  Future<void> addScrapItem(BuildContext context) async {
    if (selectedScrapType.value.isEmpty) {
      EasyLoading.showToast("Select scrap type");
      return;
    }

    List? file = await uploadImage(context);
    if (file == null) return;

    final item = ScrapItem(
      itemId: _itemCounter++,
      scrapType: selectedScrapType.value,
      scrapImg: file[1],
    );

    items.add(item);
    selectedScrapType.value = "";
  }

  void removeItem(int index) {
    items.removeAt(index);
  }

  Future<void> pickupScrap() async {
    if (!formKey.currentState!.validate() || items.isEmpty) {
      EasyLoading.showToast("Please complete all fields and add items");
      return;
    }

    Map body = {
      "userid": userInfo?.userID ?? 0,
      "fullName": nameController.text,
      "phoneNumber": phoneController.text,
      "pickupAddress": addressController.text,
      "pickupDate": dateController.text,
      "status": "Pending",
      "isPaid": true,
      "items": items.map((e) => e.toJson()).toList(),
    };

    ApiResponse apiResponse = await apiImport.pickupScrapApi(body);

    if (apiResponse.status) {
      CommonResponse response = apiResponse.data;
      scrapHome.pickupScrap();
      Get.back();
      customSnackBar(
        positin: 1,
        type: 1,
        status: "Booking Confirmed",
        message: response.message,
      );
    } else {
      customSnackBar(
        positin: 1,
        type: 0,
        status: "Failed",
        message: apiResponse.message.toString(),
      );
    }
  }

  Future<List?> uploadImage(context, {int type = 0}) async {
    final ImagePicker picker = ImagePicker();
    if (!kIsWeb) {
      isLocalAuth = false;
    }

    final XFile? image = await picker.pickImage(
      source: type == 0 ? ImageSource.gallery : ImageSource.camera,
    );

    if (image == null) return null;

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
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white,
        ),
        IOSUiSettings(title: 'Crop Image'),
        WebUiSettings(context: context),
      ],
    );

    if (croppedFile == null) return null;

    final File croppedImageFile = File(croppedFile.path);
    final Uint8List compressedBytes = await _compressImage(
      croppedImageFile,
      200 * 1024,
    );
    String base64Image = base64Encode(compressedBytes);
    Map body = {'DocBase64': base64Image};

    ApiResponse apiResponse = await apiImport.uploadImageApi(body);

    if (apiResponse.status) {
      UploadResponse response = apiResponse.data;
      return [croppedFile.path, response.requestnumber];
    } else {
      EasyLoading.showToast('Failed to upload image'.tr);
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

  void addItemFromUpload({
    required String scrapType,
    required String localPath,
    required String serverUrl,
  }) {
    final item = ScrapItem(
      itemId: _itemCounter++,
      scrapType: scrapType,
      scrapImg: serverUrl,
      localPath: localPath,
    );
    items.add(item);
  }
}

class ScrapItem {
  final int itemId;
  final String scrapType;
  final String scrapImg;
  final String? localPath;

  ScrapItem({
    required this.itemId,
    required this.scrapType,
    required this.scrapImg,
    this.localPath,
  });

  Map<String, dynamic> toJson() => {
    "itemId": itemId,
    "scrapType": scrapType,
    "scrapImg": scrapImg,
  };
}
