import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import '../controllers/connect_with_u_s_controller.dart';

class ConnectWithUSView extends GetView<ConnectWithUSController> {
  const ConnectWithUSView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ConnectWithUSController());

    return Scaffold(
      appBar: AppBar(
        title: heading('Connect', 'With Us'),
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
                controller: ctrl.messageController,
                hintText: 'Your Message',
                icon: Icons.message,
                maxLines: 5,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: ctrl.sendMessage,
                  icon: const Icon(Icons.send),
                  label: const Text('Send Message'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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

Widget customTextField({
  required TextEditingController controller,
  required String hintText,
  IconData? icon,
  int maxLines = 1,
}) {
  return TextField(
    controller: controller,
    maxLines: maxLines,
    decoration: InputDecoration(
      prefixIcon: icon != null ? Icon(icon) : null,
      hintText: hintText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      filled: true,
      fillColor: Colors.grey.shade100, // soft background
    ),
  );
}
