import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Data/storage.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';
import '../controllers/khata_clients_controller.dart';

class KhataClientsView extends GetView<KhataClientsController> {
  const KhataClientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, elevation: 0),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Get.theme.primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.receipt_long_outlined),
                      label: Text('Genrate Bill'),
                      onPressed: () {
                        Get.toNamed(
                          Routes.KHATA_BILLS,
                          arguments: {
                            "ClientId": 0,
                            "clientName": "Servizo user",
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Get.theme.canvasColor,
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text("Need help?"),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Get.theme.primaryColor.withOpacity(.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Experience seamless multi-device access and exclusive features to manage your KhataBook effortlessly. Start your hassle-free accounting today.",
                style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.account_circle_outlined, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Obx(
                      () => Text(
                        "Net Balance\n${controller.khataClientData.length} Accounts",
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Obx(
                        () => Text(
                          "₹${controller.overall.value}",
                          style: TextStyle(
                            color:
                                controller.overall.value < 0
                                    ? Colors.red
                                    : Get.theme.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Text(
                        "You Pay",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                color: Get.theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Customers",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: Obx(() {
                if (!controller.khataClientloaded.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Get.theme.primaryColor,
                    ),
                  );
                }
                if (controller.khataClientData.isEmpty) {
                  return const Center(
                    child: Text(
                      "No clients added yet",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }
                return ListView.separated(
                  separatorBuilder:
                      (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Divider(height: 1, thickness: 0.5),
                      ),
                  itemCount: controller.khataClientData.length,
                  itemBuilder: (context, index) {
                    final client = controller.khataClientData[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          Routes.KHATA_CLIENTS_PROFILE,
                          arguments: {"clientID": client},
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Get.theme.primaryColor.withOpacity(
                            .4,
                          ),
                          child: Text(
                            client.firmName.isNotEmpty
                                ? client.firmName[0]
                                : '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          client.firmName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text(
                          "Added on 10 Sept, 2025",
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "₹${client.totalBalance}",
                              style: TextStyle(
                                color:
                                    client.totalBalance < 0
                                        ? Colors.red
                                        : Get.theme.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              client.totalBalance < 0
                                  ? "Payable"
                                  : client.totalBalance > 0
                                  ? "Receivable"
                                  : "Settled",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(Routes.ADD_KHATA_CLIENTS);
        },
        backgroundColor: Get.theme.primaryColor,
        elevation: 0,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add),
        label: const Text("Add Customer"),
      ),
    );
  }
}
