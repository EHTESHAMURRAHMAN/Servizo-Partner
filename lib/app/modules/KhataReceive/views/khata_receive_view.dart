import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/khata_receive_controller.dart';

class KhataReceiveView extends GetView<KhataReceiveController> {
  const KhataReceiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0.3,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text(
                controller.khataClientData.value?.proprieterName
                        .substring(0, 1)
                        .toUpperCase() ??
                    'E',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.khataClientData.value?.proprieterName ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Text(
                  'Credit',
                  style: TextStyle(
                    color: Get.theme.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(Icons.security, color: Colors.grey[600], size: 30),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Text(
                    "SECURED",
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 0.5,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(width: 3),
                  Icon(Icons.lock, size: 16, color: Colors.blueAccent),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 12),

          // Amount Input Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextFormField(
              controller: controller.amountController,
              onChanged: (value) => controller.showNote.value = value,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: 1.2,
              ),
              decoration: InputDecoration(
                hintText: '0.0',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 38),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                prefix: const SizedBox.shrink(),
                fillColor: Colors.transparent,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Divider
          SizedBox(
            width: 100,
            child: Divider(thickness: 2, color: Get.theme.highlightColor),
          ),

          const SizedBox(height: 14),

          // Create Bills Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Get.theme.primaryColor, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  color: Get.theme.primaryColor,
                  size: 30,
                ),
                SizedBox(height: 8),
                Text(
                  "Create\nBills",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Get.theme.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),
          Obx(() {
            if (controller.showNote.value.isEmpty) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.noteController,
                      decoration: InputDecoration(
                        hintText: "Add Note (Optional)",
                        prefixIcon: const Icon(Icons.note_add),
                        suffixIcon: const Icon(Icons.mic_none),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Get.theme.primaryColor,
                    child: IconButton(
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        controller.addClientTransaction();
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
