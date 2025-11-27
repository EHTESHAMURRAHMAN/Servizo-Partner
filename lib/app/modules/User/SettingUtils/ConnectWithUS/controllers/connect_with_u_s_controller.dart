import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ConnectWithUSController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  void sendMessage() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final message = messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      Get.snackbar(
        'Missing Info',
        'Please fill out all fields.',
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.white,
      );
      return;
    }

    final smtpServer = gmail('ehtes.well@gmail.com', 'khan2002');

    final mail =
        Message()
          ..from = Address(email, name)
          ..recipients.add(
            'support@yourdomain.com',
          ) // your email to receive the message
          ..subject = 'Connect With Us Message from $name'
          ..text = 'Name: $name\nEmail: $email\n\nMessage:\n$message';

    try {
      final sendReport = await send(mail, smtpServer);
      Get.snackbar(
        'Message Sent',
        'Thank you for reaching out!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      print('Email sent: $sendReport');
    } catch (e) {
      Get.snackbar(
        'Failed',
        'Could not send email. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Email send error: $e');
    }

    nameController.clear();
    emailController.clear();
    messageController.clear();
  }
}
