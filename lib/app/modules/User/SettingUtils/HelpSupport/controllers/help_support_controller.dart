import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class HelpSupportController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final issueController = TextEditingController();

  void submitSupportRequest() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final issue = issueController.text.trim();

    if (name.isEmpty || email.isEmpty || issue.isEmpty) {
      Get.snackbar(
        'Missing Info',
        'Please fill in all fields.',
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.white,
      );
      return;
    }

    final smtpServer = gmail('your_email@gmail.com', 'your_email_password');

    final message =
        Message()
          ..from = Address(email, name)
          ..recipients.add(
            'support@yourdomain.com',
          ) // where you want to receive issues
          ..subject = 'Help & Support Query from $name'
          ..text = 'Name: $name\nEmail: $email\n\nIssue:\n$issue';

    try {
      final sendReport = await send(message, smtpServer);
      Get.snackbar(
        'Submitted',
        'Support request sent successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      Get.snackbar(
        'Failed',
        'Could not send email. Try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Message not sent. $e');
    }

    nameController.clear();
    emailController.clear();
    issueController.clear();
  }
}
