import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart'; // Assuming this contains heading and backButton
import '../controllers/security_controller.dart';

class SecurityView extends GetView<SecurityController> {
  const SecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: heading('Security', ''), // Custom widget for title
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: backButton(), // Custom back button
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Obx(
            () => ListView(
              children: [
                // Two-Factor Authentication Section
                _buildSectionTitle('Two-Factor Authentication'),
                SwitchListTile(
                  title: const Text(
                    'Enable 2FA',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text(
                    'Secure your account with an extra layer of protection',
                  ),
                  value: controller.is2FAEnabled.value,
                  onChanged: (value) {
                    controller.toggle2FA(value);
                  },
                ),
                const Divider(),

                // Change Password Section
                _buildSectionTitle('Password'),
                ListTile(
                  title: const Text(
                    'Change Password',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text('Update your account password'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    controller.navigateToChangePassword();
                  },
                ),
                const Divider(),

                // Active Sessions Section
                _buildSectionTitle('Active Sessions'),
                ...controller.activeSessions.map(
                  (session) => ListTile(
                    title: Text(
                      session['device'] ?? 'Unknown Device',
                      style: const TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      'Last active: ${session['lastActive'] ?? 'Unknown'}',
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        controller.signOutSession(session['id']);
                      },
                      child: const Text(
                        'Sign Out',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                const Divider(),

                // Account Deletion Section
                _buildSectionTitle('Account Management'),
                ListTile(
                  title: const Text(
                    'Delete Account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                  subtitle: const Text('Permanently delete your account'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    _showDeleteAccountDialog(context);
                  },
                ),
              ],
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
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Dialog for account deletion confirmation
  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Account'),
            content: const Text(
              'Are you sure you want to permanently delete your account? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  controller.deleteAccount();
                  Get.back();
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}
