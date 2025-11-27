import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/modules/User/SettingUtils/ConnectWithUS/views/connect_with_u_s_view.dart';

import '../controllers/help_support_controller.dart';

class HelpSupportView extends GetView<HelpSupportController> {
  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(HelpSupportController());

    return Scaffold(
      appBar: AppBar(
        title: heading('Help &', 'Support'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: backButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              customTextField(
                controller: ctrl.nameController,
                hintText: 'Your Name',
                icon: Icons.person,
              ),
              const SizedBox(height: 15),
              customTextField(
                controller: ctrl.emailController,
                hintText: 'Email Address',
                icon: Icons.email,
              ),
              const SizedBox(height: 15),
              customTextField(
                controller: ctrl.issueController,
                hintText: 'Describe your issue or question',
                icon: Icons.report_problem,
                maxLines: 5,
              ),
              const SizedBox(height: 25),
              ElevatedButton.icon(
                onPressed: ctrl.submitSupportRequest,
                icon: const Icon(Icons.support_agent),
                label: const Text('Submit Request'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
