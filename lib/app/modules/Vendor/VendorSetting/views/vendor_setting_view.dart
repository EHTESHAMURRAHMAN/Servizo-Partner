import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Api/base_api.dart'; // For userInfo
import 'package:servizo_vendor/app/modules/Vendor/VendorSetting/controllers/vendor_setting_controller.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';

class VendorSettingView extends GetView<VendorSettingController> {
  const VendorSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              _buildHeader(context),
              _buildSettingsSection(context),

              logoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(
              CupertinoIcons.person_fill,
              size: 80,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            userInfo?.name ?? 'Guest',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            userInfo?.email ?? 'No email provided',
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            userInfo?.role ?? "Not Recognized",
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      children: [
        _buildSettingTile(
          context,
          color: Colors.blue,
          icon: Icons.brightness_6,
          title: 'Dark Mode',
          subtitle: 'Switch between light and dark themes',
          trailing: Obx(
            () => Switch(
              value: controller.isDarkMode.value,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) => controller.toggleTheme(value),
            ),
          ),
        ),

        _buildSettingTile(
          context,
          color: Colors.pink,
          icon: Icons.notifications,
          title: 'Notifications',
          subtitle: 'Enable or disable push notifications',
          trailing: Obx(
            () => Switch(
              value: controller.enableNotifications.value,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) => controller.toggleNotifications(value),
            ),
          ),
        ),

        _buildSettingTile(
          context,
          color: Colors.green,
          icon: Icons.connect_without_contact,
          title: 'Connect with Us',
          subtitle: 'Reach out via social media or email',
          // onTap: () => Get.toNamed(Routes.CONNECT_WITH_U_S),
        ),

        _buildSettingTile(
          context,
          color: Colors.red,
          icon: Icons.security,
          title: 'Security',
          subtitle: 'Manage account security settings',
          // onTap: () => Get.toNamed(Routes.SECURITY),
        ),

        _buildSettingTile(
          context,
          color: Colors.red,
          icon: Icons.build,
          title: 'Manage Skills',
          subtitle: 'Empower your vendor growth',
          onTap: () => Get.toNamed(Routes.VENDOR_SKILL),
        ),

        _buildSettingTile(
          context,
          color: Colors.amber,
          icon: Icons.person,
          title: 'Update Profile',
          subtitle: 'Edit your profile information',
          // onTap: () => Get.toNamed(Routes.UPDATE_PROFILE),
        ),

        _buildSettingTile(
          context,
          color: Colors.teal,
          icon: Icons.support,
          title: 'Help & Support',
          subtitle: 'Get assistance or contact support',
          //onTap: () => Get.toNamed(Routes.HELP_SUPPORT),
        ),
      ],
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: ListTile(
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle:
            subtitle != null
                ? Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Get.theme.hintColor),
                )
                : null,
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }

  Widget logoutButton(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: Get.width / 3,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade800,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
          onPressed: () => _showLogoutDialog(context),
          icon: const Icon(Icons.logout, color: Colors.white),
          label: const Text(
            'Logout',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Confirm Logout',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  const Text('Are you sure you want to log out?'),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () async {
                          await controller.logout();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
