import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:servizo_vendor/app/Model/Profile_response.dart';
import 'package:servizo_vendor/app/Model/khata_profile_resp.dart';
import '../Model/common_model.dart';
import '../environment/environment.dart';

final String apiHost = Environment().config.apiHost;
final String base = Environment().config.base;
final String imgHost = Environment().config.imageHost;
final String imageHost = Environment().config.imageHost;
final String apiVersion = Environment().config.apiVersion;
var timeoutDuration = 90;

String bearerToken = '';
String? deviceId;
ProfileData? userInfo;
KhataProfileData? khataProfileData;
String userPassword = '';

Map<String, String> headers = {
  "Content-Type": "application/json; charset=UTF-8",
  "Accept": "application/json",
};

Future<ApiResponse> postRequestAPI(method, body) async {
  try {
    String url = '$apiHost/$method';
    final response = await postRequest(url, body);
    if (kDebugMode) {
      print('$url\n${jsonEncode(body)}');
    }
    ApiResponse apiResponse = responseFilter(response);
    if (apiResponse.status) {
      return ApiResponse(
        status: true,
        data: apiResponse.data,
        message: SUCCESS,
      );
    } else {
      return apiResponse;
    }
  } catch (e) {
    return ApiResponse(status: false, data: null, message: e.toString());
  }
}

Future<ApiResponse> commonPostAPI(method, body) async {
  try {
    String url = '$apiHost/$method';
    final response = await postRequest(url, body);
    ApiResponse apiResponse = responseFilter(response);
    if (apiResponse.status) {
      CommonResponse response = commonResponseFromJson(apiResponse.data);
      return ApiResponse(status: true, data: response, message: SUCCESS);
    } else {
      return apiResponse;
    }
  } catch (e) {
    return ApiResponse(status: false, data: null, message: e.toString());
  }
}

Future<ApiResponse> get3rdPartyRequestAPI(method) async {
  try {
    String url = '$method';
    print('Get => $url');
    final response = await getRequest(url);
    ApiResponse apiResponse = responseFilter(response);
    if (apiResponse.status) {
      return ApiResponse(
        status: true,
        data: apiResponse.data,
        message: SUCCESS,
      );
    } else {
      return apiResponse;
    }
  } catch (e) {
    return ApiResponse(status: false, data: null, message: e.toString());
  }
}

Future<ApiResponse> getRequestAPI(method) async {
  try {
    String url = '$apiHost/$method';
    debugPrint('Get => $url');
    final response = await getRequest(url);
    ApiResponse apiResponse = responseFilter(response);
    if (apiResponse.status) {
      return ApiResponse(
        status: true,
        data: apiResponse.data,
        message: SUCCESS,
      );
    } else {
      return apiResponse;
    }
  } catch (e) {
    return ApiResponse(status: false, data: null, message: e.toString());
  }
}

ApiResponse responseFilter(http.Response response) {
  try {
    if (kDebugMode) {
      print(response.body);
    }
    switch (response.statusCode) {
      case 200:
        var data = jsonDecode(response.body);
        if (data is Map) {
          Map map = jsonDecode(response.body);
          if (map['status'] == 'failed') {
            if (map['message'] != null) {
              if (map['message'].toString().toLowerCase().contains('expire')) {
                // Get.to(const Startview1());
                //Get.offAllNamed(Routes.BIOMATRIC_ACCESS);
              }
            }
            return ApiResponse(
              status: false,
              data: response.body,
              message: map['message'],
            );
          }
        }
        return ApiResponse(status: true, data: response.body, message: SUCCESS);
      case 408:
        return ApiResponse(
          status: false,
          data: response.body,
          message: 'Request time out',
        );
      default:
        return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(status: false, data: null, message: e.toString());
  }
}

Future<http.Response> getRequest(url) async {
  if (kDebugMode) {
    print(url);
  }

  final response = await http
      .get(Uri.parse(url), headers: headers)
      .timeout(
        Duration(seconds: timeoutDuration),
        onTimeout: () {
          return http.Response('Request time out', 408);
        },
      );
  return response;
}

Future<http.Response> postRequest(url, body, {loading = true}) async {
  if (kDebugMode) {
    print('${Uri.parse(url)}\n$body');
  }

  if (loading) EasyLoading.show();
  final response = await http
      .post(Uri.parse(url), body: json.encode(body), headers: headers)
      .timeout(
        Duration(seconds: timeoutDuration),
        onTimeout: () {
          EasyLoading.dismiss();
          return http.Response('Error', 408);
        },
      );
  EasyLoading.dismiss();
  return response;
}

const String SUCCESS = 'success';
const String ERROR = 'failure';

class ApiResponse {
  bool status;
  String? message;
  dynamic data;
  ApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApiResponse.success(data) {
    return ApiResponse(status: true, message: '', data: data);
  }

  factory ApiResponse.failed(message) {
    return ApiResponse(status: false, message: message, data: null);
  }
}
