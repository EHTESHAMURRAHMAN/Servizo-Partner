import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:servizo_vendor/app/modules/Vendor/VendorLogin/controllers/vendor_login_controller.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class VendorLoginView extends GetView<VendorLoginController> {
  const VendorLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              children: [
                const SizedBox(height: 20),

                Lottie.asset(
                  'assets/animations/login.json',
                  height: Get.height * 0.25,
                ),
                const SizedBox(height: 20),

                SizedBox(
                  height: 40,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: 1.5,
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          "Ready? Let’s Start!",
                          speed: const Duration(milliseconds: 80),
                          cursor: '|',
                          textStyle: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: controller.controllerlogin,
                  decoration: InputDecoration(
                    labelText: "Email",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator:
                      (value) => value!.isEmpty ? "Enter your email" : null,
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: controller.controllerPassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator:
                      (value) => value!.isEmpty ? "Enter your password" : null,
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 50,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => controller.login(),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Forgot Password?"),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(
                              Routes.PASSWORD_RECOVERY,
                              arguments: {"userType": 'Vendor'},
                            );
                          },
                          child: const Text(
                            "Recover here",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () => Get.toNamed(Routes.VENDOR_REGISTER),
                          child: const Text(
                            "Sign Up as Vendor",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
