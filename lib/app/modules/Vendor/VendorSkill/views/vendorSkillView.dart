import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Model/vendorSkillResp.dart';
import '../../../../Utils/Common_Widget.dart';
import '../controllers/vendorSkillController.dart';

class VendorSkillView extends GetView<VendorSkillController> {
  const VendorSkillView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: backButton(),
        title: heading('Manage Skills', ""),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => showAddSkillDialog(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.skillList.length,
                  itemBuilder: (_, i) {
                    VendorSkill item = controller.skillList[i];
                    return _buildTile(item);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(VendorSkill item) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Get.mediaQuery.size.width * 0.55,
              child: Text(
                item.skill.toString(),
                style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Color(0xff0E614A)),
                  onPressed: () {
                    Get.snackbar('Alert', 'Skill Updated');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red.shade700),
                  onPressed: () {
                    Get.snackbar('Alert', 'Skill Deleted');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showAddSkillDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        title: const Center(
          child: Text('Add Skill', style: TextStyle(color: Color(0xff0E614A))),
        ),
        content: TextField(
          controller: controller.skillController,
          decoration: InputDecoration(
            hintText: 'Enter skill',
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff0E614A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Add', style: TextStyle(color: Colors.white)),
            onPressed: () {
              String newSkill = controller.skillController.text.trim();
              if (newSkill.isNotEmpty) {
                controller.addSkill(newSkill);
              }
            },
          ),
        ],
      ),
    );
  }
}
