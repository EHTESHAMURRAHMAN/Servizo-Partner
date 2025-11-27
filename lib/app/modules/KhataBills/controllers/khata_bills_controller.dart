import 'package:get/get.dart';
import 'package:servizo_vendor/app/Api/Api_Import.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Model/khata_bills_resp.dart';
import 'package:intl/intl.dart';

class KhataBillsController extends GetxController {
  final khataBillData = RxList<KhataBillData>();
  final filteredBills = RxList<KhataBillData>(); // ✅ for filtered list

  final khataBillLoaded = false.obs;
  final ApiImport apiImport = ApiImport();

  final argument = Get.arguments;
  final clientID = 0.obs;
  final clientName = "".obs;

  // filter type
  final selectedFilter = "All Time".obs;

  @override
  void onInit() {
    super.onInit();
    if (argument != null) {
      clientID.value = argument['ClientId'] ?? 0;
      clientName.value = argument['CustomerName'] ?? "Servizo Client";
    }
    clientID.value == 0 ? getKhataBills() : getClientKhataBills();
  }

  Future<void> getKhataBills() async {
    khataBillLoaded.value = false;
    ApiResponse apiResponse = await apiImport.getUserKhataBillsApi(
      userInfo?.userID ?? 0,
    );
    if (apiResponse.status) {
      KhataBillResp response = apiResponse.data;
      khataBillData.value = response.data;
      applyFilter(); // ✅ apply filter
      khataBillLoaded.value = true;
    } else {
      khataBillLoaded.value = true;
    }
  }

  Future<void> getClientKhataBills() async {
    khataBillLoaded.value = false;
    ApiResponse apiResponse = await apiImport.getClientKhataBillsApi(
      clientID.value,
    );
    if (apiResponse.status) {
      KhataBillResp response = apiResponse.data;
      khataBillData.value = response.data;
      applyFilter(); // ✅ apply filter
      khataBillLoaded.value = true;
    } else {
      khataBillLoaded.value = true;
    }
  }

  // ✅ filter bills
  void applyFilter({DateTime? startDate, DateTime? endDate}) {
    if (selectedFilter.value == "All Time") {
      filteredBills.assignAll(khataBillData);
    } else if (selectedFilter.value == "Last 30 Days") {
      DateTime cutoff = DateTime.now().subtract(const Duration(days: 30));
      filteredBills.assignAll(
        khataBillData.where((bill) {
          if (bill.createdAt == null) return false;
          DateTime billDate = DateTime.parse(bill.createdAt!);
          return billDate.isAfter(cutoff);
        }).toList(),
      );
    } else if (selectedFilter.value == "Last 15 Days") {
      DateTime cutoff = DateTime.now().subtract(const Duration(days: 15));
      filteredBills.assignAll(
        khataBillData.where((bill) {
          if (bill.createdAt == null) return false;
          DateTime billDate = DateTime.parse(bill.createdAt!);
          return billDate.isAfter(cutoff);
        }).toList(),
      );
    } else if (selectedFilter.value == "Custom Range") {
      if (startDate != null && endDate != null) {
        filteredBills.assignAll(
          khataBillData.where((bill) {
            if (bill.createdAt == null) return false;
            DateTime billDate = DateTime.parse(bill.createdAt!);
            return billDate.isAfter(startDate) &&
                billDate.isBefore(endDate.add(const Duration(days: 1)));
          }).toList(),
        );
      }
    }
  }
}
