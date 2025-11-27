import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AppHeadingWidget extends StatelessWidget {
  const AppHeadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        VisibilityDetector(
          key: const Key("app-logo"),
          onVisibilityChanged: (info) {
            if (info.visibleFraction > 0.1) {
              debugPrint("Logo is visible ✅");
            } else {
              debugPrint("Logo is hidden ❌");
            }
          },
          child: Image.asset('assets/image/logo.png', height: 40),
        ),
        const SizedBox(width: 10),
        Text(
          'Servizo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
