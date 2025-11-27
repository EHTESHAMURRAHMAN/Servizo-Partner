import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  const UpdateProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: heading('Update Profile', ''),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: backButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Obx(
            () => Form(
              key: controller.formKey,
              child: ListView(
                children: <Widget>[
                  // Profile Picture Section
                  _buildProfilePictureSection(),
                  const SizedBox(height: 20),

                  // Name Field
                  _buildSectionTitle('Full Name'),
                  TextFormField(
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your full name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) => controller.validateName(value),
                  ),
                  const SizedBox(height: 16),

                  // Email Field
                  _buildSectionTitle('Email Address'),
                  TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => controller.validateEmail(value),
                  ),
                  const SizedBox(height: 16),

                  // Phone Number Field
                  _buildSectionTitle('Phone Number'),
                  TextFormField(
                    controller: controller.phoneController,
                    decoration: InputDecoration(
                      hintText: 'Enter your phone number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) => controller.validatePhone(value),
                  ),
                  const SizedBox(height: 30),

                  // Save Button
                  ElevatedButton(
                    onPressed:
                        controller.isLoading.value
                            ? null
                            : () => controller.saveProfile(),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child:
                        controller.isLoading.value
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              'Save Changes',
                              style: TextStyle(color: Colors.white),
                            ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method for section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Profile Picture Section
  Widget _buildProfilePictureSection() {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => controller.pickImage(),
            child: CircleAvatar(
              radius: 50,
              backgroundImage:
                  controller.profileImagePath.value.isNotEmpty
                      ? FileImage(File(controller.profileImagePath.value))
                      : null,
              child:
                  controller.profileImagePath.value.isEmpty
                      ? const Icon(Icons.person, size: 50, color: Colors.grey)
                      : null,
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () => controller.pickImage(),
            child: const Text('Change Profile Picture'),
          ),
        ],
      ),
    );
  }
}
