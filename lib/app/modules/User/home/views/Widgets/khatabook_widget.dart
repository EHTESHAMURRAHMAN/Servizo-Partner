import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../controllers/home_controller.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';

class KhatabookWidget extends GetView<HomeController> {
  const KhatabookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: controller.padding),
      child: Container(
        decoration: BoxDecoration(
          color: Get.theme.primaryColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Lottie.asset(
              'assets/animations/khatabook.json',
              height: 100,
              repeat: true,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Save and track any type of payments easily.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      elevation: 0,
                    ),
                    onPressed: () async {
                      // final String? userDataJson = prefs.getString(
                      //   StorageConstants.isKhatabookRegister,
                      // );
                      // if (userDataJson != null && userDataJson.isNotEmpty) {
                      //   try {
                      //     final Map<String, dynamic> json = jsonDecode(
                      //       userDataJson,
                      //     );
                      //     khataProfileData = KhataProfileData.fromJson(json);
                      //   } catch (e) {
                      //     khataProfileData = null;
                      //   }
                      // }
                      String isNameAvail =
                          controller.khataProfileData.value?.firmName ?? '';
                      if (isNameAvail.isNotEmpty) {
                        Get.toNamed(Routes.KHATA_CLIENTS);
                      } else {
                        Get.toNamed(Routes.KHATA_ONBOARD);
                      }
                    },
                    child: const Text(
                      'Start Tracking',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
