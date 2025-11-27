import 'package:get/get.dart';

class SecurityController extends GetxController {
  // Observable for 2FA toggle
  var is2FAEnabled = false.obs;

  // Observable list for active sessions
  var activeSessions =
      <Map<String, String>>[
        {'id': '1', 'device': 'iPhone 14', 'lastActive': '2025-06-27 15:30'},
        {
          'id': '2',
          'device': 'Chrome on Windows',
          'lastActive': '2025-06-26 10:15',
        },
      ].obs;

  // Toggle 2FA
  void toggle2FA(bool value) {
    is2FAEnabled.value = value;
    // Add logic to update 2FA status in backend
    Get.snackbar(
      '2FA ${value ? 'Enabled' : 'Disabled'}',
      'Two-factor authentication has been ${value ? 'enabled' : 'disabled'}.',
    );
  }

  // Navigate to change password screen
  void navigateToChangePassword() {
    // Replace with actual navigation to password change screen
    Get.toNamed('/change-password');
  }

  // Sign out a specific session
  void signOutSession(String? sessionId) {
    activeSessions.removeWhere((session) => session['id'] == sessionId);
    // Add logic to sign out session in backend
    Get.snackbar('Session Ended', 'The session has been signed out.');
  }

  // Delete account
  void deleteAccount() {
    // Add logic to delete account in backend
    Get.snackbar(
      'Account Deleted',
      'Your account has been permanently deleted.',
    );
    // Navigate to login or home screen after deletion
    Get.offAllNamed('/login');
  }
}
