import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';

import '../controllers/khata_onboard_controller.dart';

class KhataOnboardView extends GetView<KhataOnboardController> {
  const KhataOnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, leading: backButton()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Lottie.asset(
                'assets/animations/khatabook.json',
                height: 240,
                repeat: true,
              ),
              const SizedBox(height: 10),

              Text(
                "Welcome to Khatabook",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900, // neutral dark
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              Text(
                "A smarter way to manage your bills, clients, and payments — all in one place.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              // Feature Highlights
              Column(
                children: [
                  _featureTile(
                    icon: Icons.book_outlined,
                    title: "Track Your Bills",
                    subtitle:
                        "Keep your business expenses and sales organized.",
                  ),
                  const SizedBox(height: 16),
                  _featureTile(
                    icon: Icons.people_outline,
                    title: "Manage Clients",
                    subtitle: "Store customer details and payment history.",
                  ),
                  const SizedBox(height: 16),
                  _featureTile(
                    icon: Icons.payments_outlined,
                    title: "Record Payments",
                    subtitle: "Stay updated with reminders and clear records.",
                  ),
                ],
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: Get.width / 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.theme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.KHATA_REGISTER);
                  },
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: Colors.grey.shade700),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
