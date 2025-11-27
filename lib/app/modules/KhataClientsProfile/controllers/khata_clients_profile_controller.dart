import 'package:get/get.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Model/khata_client_resp.dart';
import 'package:servizo_vendor/app/Model/khata_client_trans_resp.dart';
import '../../../Api/api_import.dart';

class KhataClientsProfileController extends GetxController {
  final khataTransactionData = RxList<KhataTransactionData>();
  final khataClientloaded = false.obs;

  final ApiImport apiImport = ApiImport();
  final argument = Get.arguments;
  Rx<double> totalBalance = 0.0.obs;
  Rx<double> totalSend = 0.0.obs;
  Rx<double> totalReceive = 0.0.obs;
  final khataClientData = Rxn<KhataClientData>();
  @override
  void onInit() {
    super.onInit();
    if (argument != null) {
      khataClientData.value = argument['clientID'] ?? KhataClientData;
      getKhataClient();
    }
  }

  Future<void> getKhataClient() async {
    khataClientloaded.value = false;
    ApiResponse apiResponse = await apiImport.getClientTransactionApi(
      khataClientData.value?.id ?? 0,
    );
    if (apiResponse.status) {
      KhataTransactionResp response = apiResponse.data;
      totalBalance.value = response.balance;
      totalSend.value = response.totalSent;
      totalReceive.value = response.totalReceived;
      khataTransactionData.value = response.data;
      khataClientloaded.value = true;
    } else {
      khataClientloaded.value = true;
    }
  }
}
