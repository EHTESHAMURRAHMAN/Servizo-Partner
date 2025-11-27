import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/modules/User/Setting/controllers/setting_controller.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: heading('Settings', ''),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              _buildProfileSection(context),
              const SizedBox(height: 20),
              _buildSettingsSection(context),
              const SizedBox(height: 20),
              logoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Profile Section (Top Card)
  Widget _buildProfileSection(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            CupertinoIcons.person_fill,
            size: 45,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          userInfo?.name ?? 'Guest',

          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          userInfo?.email ?? 'No email provided',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          userInfo?.role ?? "Not Recognized",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      children: [
        // _buildSettingTile(
        //   icon: Icons.brightness_6,
        //   color: Colors.blue,
        //   title: 'Dark Mode',
        //   subtitle: 'Switch between light and dark themes',
        //   trailing: Obx(
        //     () => Switch(
        //       value: controller.isDarkMode.value,
        //       activeColor: Theme.of(context).primaryColor,
        //       onChanged: (value) => controller.toggleTheme(value),
        //     ),
        //   ),
        // ),
        _buildSettingTile(
          icon: Icons.notifications,
          color: Colors.pink,
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
          icon: Icons.connect_without_contact,
          color: Colors.green,
          title: 'Connect with Us',
          subtitle: 'Reach out via social media or email',
          onTap: () => Get.toNamed(Routes.CONNECT_WITH_U_S),
        ),
        _buildSettingTile(
          icon: Icons.security,
          color: Colors.red,
          title: 'Security',
          subtitle: 'Manage account security settings',
          onTap: () => Get.toNamed(Routes.SECURITY),
        ),
        _buildSettingTile(
          icon: Icons.person,
          color: Colors.amber,
          title: 'Update Profile',
          subtitle: 'Edit your profile information',
          onTap: () => Get.toNamed(Routes.UPDATE_PROFILE),
        ),
        _buildSettingTile(
          icon: Icons.support,
          color: Colors.teal,
          title: 'Help & Support',
          subtitle: 'Get assistance or contact support',
          onTap: () => Get.toNamed(Routes.HELP_SUPPORT),
        ),
      ],
    );
  }

  /// Setting Tile (Material clean design)
  Widget _buildSettingTile({
    required IconData icon,
    required Color color,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Get.theme.canvasColor,
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle:
            subtitle != null
                ? Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                )
                : null,
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  /// Logout Button
  Widget logoutButton() {
    return SizedBox(
      width: Get.width / 2,
      height: 48,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => showConfirmDialog(Get.context!),
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
    );
  }

  void showConfirmDialog(context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Are you sure?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text('This action cannot be undone.'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    FilledButton.tonal(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        await controller.logout();
                        Get.offAllNamed(Routes.ONBOARD);
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
