import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: backButton(),
        title: heading('Register', ''),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: controller.regiFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/animations/login.json',
                  height: Get.height * 0.25,
                ),
                const SizedBox(height: 20),

                _InputField(
                  controller: controller.controllerName,
                  label: "Full Name",
                  icon: Icons.person,
                  validator:
                      (value) => value!.isEmpty ? "Enter your Name" : null,
                ),
                const SizedBox(height: 15),

                _InputField(
                  controller: controller.controllerMobile,
                  label: "Phone",
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator:
                      (value) => value!.isEmpty ? "Enter your Phone" : null,
                ),
                const SizedBox(height: 15),

                _InputField(
                  controller: controller.controllerEmail,
                  label: "Email",
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator:
                      (value) => value!.isEmpty ? "Enter your Email" : null,
                ),
                const SizedBox(height: 15),

                _PasswordField(
                  controller: controller.controllerPassword,
                  validator:
                      (value) => value!.isEmpty ? "Enter your Password" : null,
                ),
                const SizedBox(height: 15),

                _InputField(
                  controller: controller.controllerAddress,
                  label: "Address",
                  icon: Icons.location_on,
                  validator:
                      (value) => value!.isEmpty ? "Enter your Address" : null,
                ),
                const SizedBox(height: 25),

                Align(
                  child: SizedBox(
                    width: Get.width / 3,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: controller.register,

                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                _TextLinkRow(
                  text: "Already have an account?",
                  linkText: "Login",
                  onTap: () => Get.back(),
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

  const _InputField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
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

class _PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const _PasswordField({required this.controller, this.validator});

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      validator: widget.validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.canvasColor,
        labelText: "Password",
        prefixIcon: Icon(Icons.lock, color: theme.primaryColor),
        suffixIcon: IconButton(
          icon: Icon(
            _obscure ? Icons.visibility_off : Icons.visibility,
            color: theme.primaryColor,
          ),
          onPressed: () => setState(() => _obscure = !_obscure),
        ),
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
