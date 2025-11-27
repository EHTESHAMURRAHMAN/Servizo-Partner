import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Api/api_import.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Model/common_model.dart';
import 'package:servizo_vendor/app/modules/User/home/controllers/home_controller.dart';

import '../../../../Model/BookingModel.dart';

class VenderListController extends GetxController {
  final homeController = Get.find<HomeController>();

  ApiImport apiImpl = ApiImport();

  final bookfor = TextEditingController();
  final description = TextEditingController();
  final street = TextEditingController();
  final city = TextEditingController();
  final zipcode = TextEditingController();
  var alternatePhone = TextEditingController();
  final bookingData = RxList<UserBookingData>();
  final formKey = GlobalKey<FormState>();
  DateTime? lastDate;
  final datetime = "".obs;

  booking({serviceId, vendorID, context}) async {
    if (lastDate == null) {
      return Get.snackbar(
        "Alert!",
        "Please Select Date",
        icon: const Icon(Icons.warning, color: Colors.white, size: 30),
        backgroundColor: Colors.red.shade800,
        colorText: Colors.white,
      );
    }

    print("service id $serviceId");
    Map body = {
      "serviceId": serviceId,
      "userId": userInfo!.userID,
      "vendorId": vendorID,
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
      print(resp);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          String message = "Service booked successfully";
          IconData icon = Icons.done;
          if (resp.status == 'failed') {
            message = "Service booking failed";
            icon = Icons.error;
          }

          return AlertDialog(
            title: Text(message),
            icon: Icon(icon, size: 80),
            actions: [
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Done"),
                  ),
                ),
              ),
            ],
          );
        },
      );

      Get.back();
      Get.back();
    }
  }
}
