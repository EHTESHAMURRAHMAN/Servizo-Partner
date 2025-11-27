import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servizo_vendor/app/Api/base_api.dart';

class UpdateProfileController extends GetxController {
  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Text controllers for form fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  // Observable for profile image path
  var profileImagePath = ''.obs;

  // Observable for loading state
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with existing user data (replace with actual data fetching)
    nameController.text = userInfo!.name; // Mock data
    emailController.text = userInfo!.email; // Mock data
    phoneController.text = userInfo!.phone; // Mock data
  }

  // Validate name
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  // Validate email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Validate phone number
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // Pick image from gallery
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImagePath.value = pickedFile.path;
    }
  }

  // Save profile changes
  void saveProfile() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Add backend API call here to save profile data
      // final profileData = {
      //   'name': nameController.text,
      //   'email': emailController.text,
      //   'phone': phoneController.text,
      //   'profileImage': profileImagePath.value,
      // };

      // Mock success response
      Get.snackbar('Success', 'Profile updated successfully');
      isLoading.value = false;

      // Optionally navigate back
      // Get.back();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
