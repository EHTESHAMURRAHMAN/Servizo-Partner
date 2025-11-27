import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: heading('Login', ''),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/animations/login.json',
                  height: Get.height * 0.25,
                ),
                const SizedBox(height: 20),

                SizedBox(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onBackground,
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
                const SizedBox(height: 5),

                Text(
                  "Login to continue",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 30),

                _InputField(
                  controller: controller.controllerlogin,
                  label: "Enter your email or phone",
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator:
                      (value) =>
                          value!.isEmpty ? "Enter your email or phone" : null,
                ),
                const SizedBox(height: 18),

                _InputField(
                  controller: controller.controllerPassword,
                  label: "Password",
                  icon: Icons.lock,
                  obscure: true,
                  validator:
                      (value) => value!.isEmpty ? "Enter your password" : null,
                ),
                const SizedBox(height: 26),

                Align(
                  child: SizedBox(
                    height: 50,
                    width: Get.width / 3,
                    child: ElevatedButton(
                      onPressed: controller.login,
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                _TextLinkRow(
                  text: "Forgot Password?",
                  linkText: "Recover here",
                  onTap:
                      () => Get.toNamed(
                        Routes.PASSWORD_RECOVERY,
                        arguments: {"userType": 'User'},
                      ),
                ),

                _TextLinkRow(
                  text: "Don't have an account?",
                  linkText: "Sign Up",
                  onTap: () => Get.toNamed(Routes.REGISTER),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool obscure;

  const _InputField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.validator,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.canvasColor,
        labelText: label,
        prefixIcon: Icon(icon, color: theme.primaryColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(14),
      ),
    );
  }
}

class _TextLinkRow extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback onTap;

  const _TextLinkRow({
    required this.text,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: theme.textTheme.bodyMedium),
        TextButton(
          onPressed: onTap,
          child: Text(
            linkText,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
