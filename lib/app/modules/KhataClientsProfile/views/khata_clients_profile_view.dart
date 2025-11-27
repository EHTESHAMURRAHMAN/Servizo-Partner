import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';

import '../controllers/khata_clients_profile_controller.dart';

class KhataClientsProfileView extends GetView<KhataClientsProfileController> {
  const KhataClientsProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    String formattedTime = "11:30 PM";
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: backButton(),
        title: Text(
          controller.khataClientData.value?.proprieterName ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.receipt_long_outlined,
              color: Get.theme.primaryColor,
            ),
            onPressed: () {
              Get.toNamed(
                Routes.KHATA_BILLS,
                arguments: {
                  "ClientId": controller.khataClientData.value?.id ?? 0,
                  "clientName":
                      controller.khataClientData.value?.proprieterName ?? "",
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Expanded(
            child: Obx(() {
              final txList = controller.khataTransactionData;
              if (!controller.khataClientloaded.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Get.theme.primaryColor,
                  ),
                );
              }
              if (txList.isEmpty) {
                return noData();
              }
              return ListView.builder(
                reverse: true,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: txList.length,
                itemBuilder: (context, index) {
                  final tx = txList[index];
                  final isReceived =
                      tx.transactionType.toLowerCase() == "receive";
                  final timePart =
                      (tx.transactionDate.contains('T') &&
                              tx.transactionDate.length > 10)
                          ? tx.transactionDate.split('T').last
                          : formattedTime;

                  return Align(
                    alignment:
                        isReceived
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Get.theme.hintColor),
                        borderRadius: BorderRadius.only(
                          topLeft:
                              isReceived
                                  ? const Radius.circular(20)
                                  : const Radius.circular(0),
                          topRight:
                              isReceived
                                  ? const Radius.circular(0)
                                  : const Radius.circular(20),
                          bottomLeft:
                              isReceived
                                  ? const Radius.circular(0)
                                  : const Radius.circular(20),
                          bottomRight:
                              isReceived
                                  ? const Radius.circular(20)
                                  : const Radius.circular(0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '₹${tx.amount}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color:
                                  isReceived
                                      ? Get.theme.primaryColor
                                      : Colors.red,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (tx.description.isNotEmpty)
                            Text(
                              tx.description,
                              style: const TextStyle(color: Colors.black87),
                            ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                timePart,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Get.theme.hintColor,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.check,
                                size: 16,
                                color: Get.theme.primaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 0,
              right: 0,
              bottom: 12,
              top: 6,
            ),
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.share, color: Get.theme.primaryColor),
                label: Text(
                  'Share',
                  style: TextStyle(color: Get.theme.primaryColor),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  foregroundColor: Get.theme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Get.theme.primaryColor),
                  ),
                ),
              ),
            ),
          ),

          // Balance display
          Container(
            color: const Color(0xfff6f7fa),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
            child: Row(
              children: [
                Text(
                  'Balance Advance',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Obx(
                  () => Text(
                    '₹${controller.totalBalance.value}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Buttons for Received and Given navigation
          Container(
            color: const Color(0xfff6f7fa),
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed(
                        Routes.KHATA_RECEIVE,
                        arguments: {
                          'khataClientData': controller.khataClientData.value,
                        },
                      );
                    },
                    icon: Icon(
                      Icons.arrow_downward,
                      color: Get.theme.primaryColor,
                    ),
                    label: Text(
                      'Received',
                      style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      foregroundColor: Get.theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed(
                        Routes.KHATA_SEND,
                        arguments: {
                          'khataClientData': controller.khataClientData.value,
                        },
                      );
                    },
                    icon: const Icon(Icons.arrow_upward, color: Colors.red),
                    label: const Text(
                      'Given',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      foregroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xfff6f7fa),
    );
  }
}
