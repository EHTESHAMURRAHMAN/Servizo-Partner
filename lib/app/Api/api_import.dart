import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:servizo_vendor/app/Api/Api.dart';
import 'package:servizo_vendor/app/Api/Api_Path.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Data/storage.dart';
import 'package:servizo_vendor/app/Model/AuthResp.dart';
import 'package:servizo_vendor/app/Model/BookingModel.dart';
import 'package:servizo_vendor/app/Model/CategoryResp.dart';
import 'package:servizo_vendor/app/Model/Profile_response.dart';
import 'package:servizo_vendor/app/Model/VenderBooking.dart';
import 'package:servizo_vendor/app/Model/VendorList_resp.dart';
import 'package:servizo_vendor/app/Model/common_model.dart';
import 'package:servizo_vendor/app/Model/khata_bills_resp.dart';
import 'package:servizo_vendor/app/Model/khata_client_resp.dart';
import 'package:servizo_vendor/app/Model/khata_client_trans_resp.dart';
import 'package:servizo_vendor/app/Model/khata_profile_resp.dart';
import 'package:servizo_vendor/app/Model/picked_scrap_resp.dart';

import 'package:servizo_vendor/app/Model/subCategoryResp.dart';
import 'package:servizo_vendor/app/Model/upload_resp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/Booking_Resp.dart';
import '../Model/VenderServiceResp.dart';
import '../Model/VendersResp.dart';

class ApiImport extends API {
  @override
  Future<ApiResponse> signUpApi(Map body) async {
    ApiResponse apiResponse = await postRequestAPI(register, body);
    if (apiResponse.status) {
      AuthResp response = authRespFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.message);
  }

  @override
  Future<ApiResponse> getProfileApi(int id) async {
    ApiResponse apiResponse = await getRequestAPI('$getprofile/$id');
    if (apiResponse.status) {
      ProfileResp response = profileRespFromJson(apiResponse.data);
      saveUserData(response.data!);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.message);
  }

  void saveUserData(ProfileData userResponse) {
    final prefs = Get.find<SharedPreferences>();
    var mData = prefs.getString(StorageConstants.userInfo);
    List<ProfileData> users =
        mData == null
            ? []
            : List<ProfileData>.from(
              jsonDecode(mData).map((x) => ProfileData.fromJson(x)),
            );
    var mList =
        users
            .where((element) => element.userID == userResponse.userID)
            .toList();

    if (mList.isEmpty) {
      users.add(userResponse);
    }

    String encodedData = jsonEncode(users.map((x) => x.toJson()).toList());
    prefs.setString(StorageConstants.userInfo, encodedData);
    userInfo = userResponse;
  }

  @override
  Future<ApiResponse> signinApi(Map body) async {
    ApiResponse apiResponse = await postRequestAPI(signin, body);
    if (apiResponse.status) {
      AuthResp response = authRespFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.message);
  }

  @override
  Future<ApiResponse> getCategoryApi() async {
    ApiResponse apiResponse = await getRequestAPI(category);
    if (apiResponse.status) {
      CategoryResp response = categoryRespFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.message);
  }

  @override
  Future<ApiResponse> getSubCategoryApi(int id) async {
    ApiResponse apiResponse = await getRequestAPI('$subcategory/$id');
    if (apiResponse.status) {
      SubcategoryResp response = subcategoryRespFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.message);
  }

  @override
  Future<ApiResponse> getVendorListApi(int vid) async {
    ApiResponse apiResponse = await getRequestAPI('$getVendorList/$vid');
    if (apiResponse.status) {
      VendorListResp response = vendorListRespFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.message);
  }

  @override
  Future<ApiResponse> getVendersApi(int id) async {
    ApiResponse apiResponse = await getRequestAPI('$getvenderbyCid/$id');
    if (apiResponse.status) {
      VendersResp response = vendersRespFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.message);
  }

  @override
  Future<ApiResponse> getUserBookingApi(int id) async {
    ApiResponse apiResponse = await getRequestAPI('$getUserbooking/$id');
    if (apiResponse.status) {
      UserBookingsResp response = userBookingsRespFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.message);
  }

  @override
  Future<ApiResponse> getvenderBookingApi(int id) async {
    ApiResponse apiResponse = await getRequestAPI('$getVenderbooking/$id');
    if (apiResponse.status) {
      VendorBookingsResp response = vendorBookingsRespFromJson(
        apiResponse.data,
      );
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.message);
  }

  @override
  Future<ApiResponse> bookingApi(Map body) async {
    ApiResponse apiResponse = await postRequestAPI(booking, body);
    if (apiResponse.status) {
      CommonResponse response = commonResponseFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.message);
  }

  // edit
  @override
  Future<ApiResponse> updateBookingApi(body) async {
    ApiResponse apiResponse = await postRequestAPI(updateBooking, body);

    if (apiResponse.status) {
      CommonResponse responseData = commonResponseFromJson(
        apiResponse.data as String,
      );

      return ApiResponse.success(responseData);
    } else {
      return ApiResponse.failed(apiResponse.message);
    }
  }

  @override
  Future<ApiResponse> addVendorServiceApi(Map body) async {
    ApiResponse apiResponse = await postRequestAPI(addVendorService, body);
    if (apiResponse.status) {
      VendorServiceResp response = vendorServiceRespFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.message);
  }

  @override
  Future<ApiResponse> uploadImageApi(body) async {
    ApiResponse apiResponse = await postRequestAPI(uploadImage, body);
    if (apiResponse.status) {
      UploadResponse response = uploadResponseFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.message);
  }

  Future<ApiResponse> completeBookingApi(int bookingId) async {
    {
      try {
        String url = '$apiHost/$completebooking?bookingId=$bookingId';

        final response = await post(Uri.parse(url));
        ApiResponse apiResponse = responseFilter(response);

        if (apiResponse.status) {
          BookResp responseData = bookRespFromJson(apiResponse.data as String);
          if (kDebugMode) {
            print('Success Response: ${jsonEncode(responseData.toJson())}');
          }
          return ApiResponse.success(responseData);
        } else {
          if (kDebugMode) {
            print('Error Response: ${apiResponse.data}');
          }
          return ApiResponse.failed(
            apiResponse.message ?? 'Failed to Complete booking',
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print('Exception: $e');
        }
        return ApiResponse.failed(e.toString());
      }
    }
  }

  @override
  Future<ApiResponse> pickupScrapApi(Map body) async {
    ApiResponse apiResponse = await postRequestAPI(bookScrapPickup, body);
    if (apiResponse.status) {
      CommonResponse response = commonResponseFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.data);
  }

  @override
  Future<ApiResponse> getPickedScrapApi(int id) async {
    ApiResponse apiResponse = await getRequestAPI('$getUserScrapBookings/$id');
    if (apiResponse.status) {
      PickedScrapResp response = pickedScrapRespFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.data);
  }

  @override
  Future<ApiResponse> updateScrapStatusApi(Map body) async {
    ApiResponse apiResponse = await postRequestAPI(updatescrapstatus, body);
    if (apiResponse.status) {
      CommonResponse response = commonResponseFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.data);
  }

  @override
  Future<ApiResponse> getKhataClientApi(int id) async {
    ApiResponse apiResponse = await getRequestAPI('$getKhataClient/$id');
    if (apiResponse.status) {
      KhataClientResp response = khataClientRespFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.data);
  }

  @override
  Future<ApiResponse> addKhataClientApi(Map body) async {
    ApiResponse apiResponse = await postRequestAPI(addKhataClient, body);
    if (apiResponse.status) {
      CommonResponse response = commonResponseFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.data);
  }

  @override
  Future<ApiResponse> updateKhataClientApi(Map body) async {
    ApiResponse apiResponse = await postRequestAPI(updateKhataClient, body);
    if (apiResponse.status) {
      CommonResponse response = commonResponseFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.data);
  }

  @override
  Future<ApiResponse> getClientTransactionApi(int id) async {
    ApiResponse apiResponse = await getRequestAPI('$getClientTransaction/$id');
    if (apiResponse.status) {
      KhataTransactionResp response = khataTransactionRespFromJson(
        apiResponse.data,
      );
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.data);
  }

  @override
  Future<ApiResponse> addClientTransactionApi(Map body) async {
    ApiResponse apiResponse = await postRequestAPI(addClientTransaction, body);
    if (apiResponse.status) {
      CommonResponse response = commonResponseFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.data);
  }

  @override
  Future<ApiResponse> getUserKhataBillsApi(int id) async {
    ApiResponse apiResponse = await getRequestAPI('$getBillsByUser/$id');
    if (apiResponse.status) {
      KhataBillResp response = khataBillRespFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.data);
  }

  @override
  Future<ApiResponse> getClientKhataBillsApi(int clientid) async {
    ApiResponse apiResponse = await getRequestAPI(
      '$getBillsByclientid/$clientid',
    );
    if (apiResponse.status) {
      KhataBillResp response = khataBillRespFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.data);
  }

  @override
  Future<ApiResponse> addKhataBillsApi(Map body) async {
    ApiResponse apiResponse = await postRequestAPI(addKhataBills, body);
    if (apiResponse.status) {
      CommonResponse response = commonResponseFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.data);
  }

  // @override
  // Future<ApiResponse> updateKhataBillsApi(Map body) async {
  //   ApiResponse apiResponse = await postRequestAPI(updateKhataBills, body);
  //   if (apiResponse.status) {
  //     CommonResponse response = commonResponseFromJson(apiResponse.data);
  //     return ApiResponse.success(response);
  //   }
  //   return ApiResponse.failed(apiResponse.data);
  // }

  // @override
  // Future<ApiResponse> deleteKhataBillsApi(Map body) async {
  //   ApiResponse apiResponse = await postRequestAPI(deleteKhataBills, body);
  //   if (apiResponse.status) {
  //     CommonResponse response = commonResponseFromJson(apiResponse.data);
  //     return ApiResponse.success(response);
  //   }
  //   return ApiResponse.failed(apiResponse.data);
  // }

  @override
  Future<ApiResponse> updateBillPayStatusAPi(Map body) async {
    ApiResponse apiResponse = await postRequestAPI(updateBillPayStatus, body);
    if (apiResponse.status) {
      CommonResponse response = commonResponseFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.data);
  }

  @override
  Future<ApiResponse> registerKhatabookApi(Map body) async {
    ApiResponse apiResponse = await postRequestAPI(khataRegisterUser, body);
    if (apiResponse.status) {
      CommonResponse response = commonResponseFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.data);
  }

  @override
  Future<ApiResponse> getKhataUserProfileApi(int id) async {
    ApiResponse apiResponse = await getRequestAPI('$getKhataUserProfile/$id');
    if (apiResponse.status) {
      KhataProfileResp response = khataProfileRespFromJson(apiResponse.data);
      return ApiResponse.success(response);
    }
    return ApiResponse.failed(apiResponse.data);
  }
}
