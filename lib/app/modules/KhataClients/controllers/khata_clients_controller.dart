import 'package:get/get.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Api/api_import.dart';
import 'package:servizo_vendor/app/Model/khata_client_resp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KhataClientsController extends GetxController {
  final prefs = Get.find<SharedPreferences>();
  final khataClientData = RxList<KhataClientData>();
  final khataClientloaded = false.obs;
  final overall = 0.0.obs;
  final ApiImport apiImport = ApiImport();
  @override
  void onInit() {
    super.onInit();
    getKhataClient();
  }

  Future<void> getKhataClient() async {
    khataClientloaded.value = false;
    ApiResponse apiResponse = await apiImport.getKhataClientApi(
      userInfo?.userID ?? 0,
    );
    if (apiResponse.status) {
      KhataClientResp response = apiResponse.data;
      khataClientData.value = response.data;
      overall.value = response.overallBalance;
      khataClientloaded.value = true;
    } else {
      khataClientloaded.value = true;
    }
  }
}
