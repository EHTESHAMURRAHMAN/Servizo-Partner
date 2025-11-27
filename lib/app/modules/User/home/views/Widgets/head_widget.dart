import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:servizo_vendor/app/modules/User/home/controllers/home_controller.dart';

class HeadWidget extends GetView<HomeController> {
  const HeadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: controller.padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RepaintBoundary(
            child: Lottie.asset(
              "assets/animations/address.json",
              height: 50,
              repeat: true,
            ),
          ),
          const SizedBox(width: 8),
          _buildLocationBox(),
          const Spacer(),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildLocationBox() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Servizo",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(controller.locality.value, style: _subStyle),
          Text(controller.country.value, style: _subStyle),
        ],
      ),
    ),
  );

  Widget _buildActionButtons(context) => Row(
    children: [
      _iconButton(CupertinoIcons.bell_fill, () {}),
      const SizedBox(width: 10),
      _iconButton(CupertinoIcons.person_fill, () {}),
    ],
  );

  Widget _iconButton(IconData icon, VoidCallback onTap) => Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Get.theme.canvasColor,
          border: Border.all(color: Get.theme.hintColor, width: .5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, size: 25, color: Colors.black87),
      ),
    ),
  );

  TextStyle get _subStyle =>
      const TextStyle(fontSize: 13, color: Colors.black54);
}
