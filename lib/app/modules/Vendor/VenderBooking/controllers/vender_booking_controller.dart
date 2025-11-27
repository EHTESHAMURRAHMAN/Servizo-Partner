import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Api/api_import.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Model/VenderBooking.dart';
import 'package:servizo_vendor/app/Model/common_model.dart';

class VenderBookingController extends GetxController {
  final bookingData = RxList<VendorBookingData>();
  final isBookingDataLoad = false.obs;
  ApiImport apiImpl = ApiImport();
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getBookedData();
  }

  Future<void> getBookedData() async {
    isBookingDataLoad.value = false;
    ApiResponse apiResponse = await apiImpl.getvenderBookingApi(
      userInfo?.userID ?? 0,
    );
    if (apiResponse.status) {
      VendorBookingsResp response = apiResponse.data;
      bookingData.value = response.data;
      isBookingDataLoad.value = true;
    } else {
      EasyLoading.showToast(apiResponse.message.toString());
    }
  }

  Future<void> updateBookingData({
    int? bookingId,
    String? statusType,
    required BuildContext context,
  }) async {
    Map body = <String, dynamic>{
      "bookingId": bookingId,
      "statusType": statusType,
    };

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Update Booking"),
          content: const Text("Are you sure you want to update this booking?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () async {
                ApiResponse apiResponse = await apiImpl.updateBookingApi(body);

                CommonResponse responseData = apiResponse.data;
                Navigator.pop(context, false);
                Get.back();

                getBookedData();
                EasyLoading.showToast(responseData.message);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
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

  Future<void> onCancelPressed(
    BuildContext context, {
    required int bookingId,
    required String statusType,
  }) async {
    showDialog<bool>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text(
              'Confirm Cancellation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'Are you sure you want to cancel this booking?',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  updateBookingData(
                    bookingId: bookingId,
                    statusType: statusType,
                    context: dialogContext,
                  );
                  Navigator.pop(dialogContext, true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Yes'),
              ),
            ],
          ),
    );
  }

  String getFullAddress(String street, String city, String zipCode) {
    return "$street,$city,$zipCode";
  }
}
