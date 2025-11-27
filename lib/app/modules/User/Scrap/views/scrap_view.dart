import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';
import '../controllers/scrap_controller.dart';

class ScrapView extends GetView<ScrapController> {
  const ScrapView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: backButton(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
            children: [
              Image.asset('assets/icons/scrap.png', height: Get.height / 8),
              const SizedBox(height: 40),

              const Text(
                "Recycle & Earn",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              Text(
                "Turn your unused scrap into value! Our Scrap Collection "
                "service helps you responsibly dispose of old materials like "
                "plastic, metal, and paper while also earning money for it. "
                "Just book a pickup, and our team will handle the rest.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 30),

              Column(
                children: [
                  _benefitTile(
                    icon: Icons.eco_rounded,
                    title: "Eco-Friendly",
                    description:
                        "Help reduce waste and promote a cleaner environment.",
                  ),
                  _benefitTile(
                    icon: Icons.attach_money,
                    title: "Earn Cash",
                    description:
                        "Get instant value for your recyclable materials.",
                  ),
                  _benefitTile(
                    icon: Icons.schedule,
                    title: "Easy Pickup",
                    description:
                        "Schedule a pickup at your convenience, hassle-free.",
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Align(
                child: SizedBox(
                  height: 55,
                  width: Get.width / 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.SCRAP_HOME);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: theme.primaryColor,
                    ),
                    child: const Text(
                      "My Scraps",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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
}

Widget _benefitTile({
  required IconData icon,
  required String title,
  required String description,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: Colors.green.withOpacity(0.1),
          child: Icon(icon, size: 24, color: Colors.green),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
