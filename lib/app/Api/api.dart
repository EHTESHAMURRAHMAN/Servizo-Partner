import 'package:servizo_vendor/app/Api/Base_Api.dart';

abstract class API {
  Future<ApiResponse> signUpApi(Map body);
  Future<ApiResponse> signinApi(Map body);
  Future<ApiResponse> getProfileApi(int id);
  Future<ApiResponse> getCategoryApi();
  Future<ApiResponse> getSubCategoryApi(int id);
  Future<ApiResponse> getVendersApi(int id);
  Future<ApiResponse> getUserBookingApi(int id);
  Future<ApiResponse> getvenderBookingApi(int id);
  Future<ApiResponse> bookingApi(Map body);
  Future<ApiResponse> addVendorServiceApi(Map body);
  Future<ApiResponse> getVendorListApi(int vid);
  Future<ApiResponse> uploadImageApi(Map body);
  Future<ApiResponse> updateBookingApi(Map body);
  Future<ApiResponse> pickupScrapApi(Map body);
  Future<ApiResponse> getPickedScrapApi(int id);
  Future<ApiResponse> updateScrapStatusApi(Map body);
  Future<ApiResponse> getKhataClientApi(int id);
  Future<ApiResponse> addKhataClientApi(Map body);
  Future<ApiResponse> updateKhataClientApi(Map body);
  Future<ApiResponse> getClientTransactionApi(int id);
  Future<ApiResponse> addClientTransactionApi(Map body);
  Future<ApiResponse> getUserKhataBillsApi(int id);
  Future<ApiResponse> addKhataBillsApi(Map body);
  // Future<ApiResponse> updateKhataBillsApi(Map body);
  // Future<ApiResponse> deleteKhataBillsApi(Map body);
  Future<ApiResponse> getClientKhataBillsApi(int clientid);
  Future<ApiResponse> registerKhatabookApi(Map body);
  Future<ApiResponse> updateBillPayStatusAPi(Map body);
  Future<ApiResponse> getKhataUserProfileApi(int id);
}
