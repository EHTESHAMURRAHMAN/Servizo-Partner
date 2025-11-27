import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Model/BookingModel.dart';
import 'package:servizo_vendor/app/Model/common_model.dart';
import 'package:servizo_vendor/app/modules/User/VenderList/controllers/vender_list_controller.dart';

import '../../../../Api/api_import.dart';
import '../../../../Api/Base_Api.dart';

class MyBookingsController extends GetxController {
  final bookingData = RxList<UserBookingData>();
  final isBookingDataLoad = false.obs;
  ApiImport apiImpl = ApiImport();

  final bookfor = TextEditingController();
  final street = TextEditingController();
  final city = TextEditingController();
  final zipcode = TextEditingController();
  var alternatePhone = TextEditingController();

  DateTime? lastDate;
  final datetime = "".obs;
  VenderListController venderListController = Get.put(VenderListController());

  @override
  void onInit() {
    super.onInit();
    getBookedData();
  }

  Future<void> getBookedData() async {
    isBookingDataLoad.value = false;
    ApiResponse apiResponse = await apiImpl.getUserBookingApi(userInfo!.userID);
    if (apiResponse.status) {
      UserBookingsResp response = apiResponse.data;
      bookingData.value = response.data;
      isBookingDataLoad.value = true;
    } else {
      EasyLoading.showToast(apiResponse.message.toString());
    }
    update();
  }

  Future<void> updateBookingData({int? bookingId, String? statusType}) async {
    Map body = {"bookingId": bookingId, "statusType": statusType};
    ApiResponse apiResponse = await apiImpl.updateBookingApi(body);
    if (apiResponse.status) {
      CommonResponse responseData = apiResponse.data;
      getBookedData();
      EasyLoading.showToast(responseData.message);
    } else {
      EasyLoading.showToast(apiResponse.message ?? 'Error cancelling booking');
    }
    getBookedData();
    onInit();
  }

  String getStatus(int status) {
    List statusList = <String>[
      'Pending',
      "Cancelled By Vendor",
      "Cancelled By User",
      "Approved By Vendor",
      "Completed",
    ];
    return statusList[status];
  }

  String getMaskedPhoneNumber(String vendorPhone) {
    return "${vendorPhone.toString().substring(0, 2)}*******";
  }

  String getFullAddress(String street, String city, String zipCode) {
    return "$street $city $zipCode";
  }

  editBookingData(UserBookingData userBookingData) async {
    if (lastDate == null) {
      return Get.snackbar(
        "Alert!",
        "Please Select Date",
        icon: Icon(Icons.warning, color: Colors.white, size: 30),
        backgroundColor: Colors.red.shade800,
        colorText: Colors.white,
      );
    }
    // print("service id ${userBookingData.serviceId}");
    Map body = {
      // "serviceId": userBookingData.serviceId,
      "userId": userInfo!.userID,
      // "vendorId": userBookingData.vendorId,
      "status": 0,
      'bookFor': bookfor.text,
      'alternatePhone': alternatePhone.text,
      'lastDate': lastDate?.toIso8601String(),
      'street': street.text,
      'city': city.text,
      "zipCode": zipcode.text,
    };
    print(body);

    ApiResponse apiResponse = await apiImpl.bookingApi(body);
    if (apiResponse.status) {
      CommonResponse resp = apiResponse.data;
      EasyLoading.showToast(resp.message);

      Get.back();
      Get.back();
    }
  }
}
