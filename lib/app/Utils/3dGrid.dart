import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Grid item with icon + label
Widget threeDGrid({required String imageUrl, required String text}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 2),
    decoration: BoxDecoration(
      color: Get.theme.canvasColor,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(color: Colors.black26, offset: Offset(2, 2), blurRadius: 3),
        BoxShadow(color: Colors.white70, offset: Offset(-2, -2), blurRadius: 3),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 60,
          height: 60,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              errorWidget:
                  (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 40,
                    color: Colors.grey,
                  ),
              placeholder:
                  (context, url) =>
                      const Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

/// Service card with optional large size
Widget threeDServiceCard({
  required Map<String, String> service,
  required bool isLarge,
}) {
  return SizedBox(
    height: isLarge ? 200 : 95,
    width: isLarge ? 140 : 90,
    child: Container(
      decoration: BoxDecoration(
        color: Get.theme.canvasColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black26, offset: Offset(3, 3), blurRadius: 4),
          BoxShadow(
            color: Colors.white70,
            offset: Offset(-3, -3),
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Icon
            Container(
              width: isLarge ? 80 : 40,
              height: isLarge ? 80 : 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: service["icon"]!,
                  fit: BoxFit.cover,
                  errorWidget:
                      (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                        size: 30,
                        color: Colors.grey,
                      ),
                  placeholder:
                      (context, url) => const Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 1.5),
                        ),
                      ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            /// Title
            Text(
              service["name"]!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isLarge ? 13 : 11,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
