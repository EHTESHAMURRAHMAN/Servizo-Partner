import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/modules/KhataRegister/controllers/khata_register_controller.dart';

class KhataRegisterView extends GetView<KhataRegisterController> {
  const KhataRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: backButton(),
        title: heading('Register', ''),
        centerTitle: true,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Lottie.asset(
                'assets/animations/khatabook.json',
                height: 150,
                repeat: false,
              ),
              _inputField("Full Name", controller.fullName),
              _inputField("Firm Name", controller.firmName),
              _inputField("Email", controller.email),
              _inputField(
                "Phone Number",
                controller.phoneNumber,
                keyboardType: TextInputType.phone,
              ),
              _inputField("Password", controller.password, isPassword: true),
              _inputField("Address", controller.address),
              _inputField("GST Number", controller.gstNumber),

              const SizedBox(height: 20),

              controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Get.theme.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () => controller.registerUser(),
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
            ],
          ),
        );
      }),
    );
  }

  Widget _inputField(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
