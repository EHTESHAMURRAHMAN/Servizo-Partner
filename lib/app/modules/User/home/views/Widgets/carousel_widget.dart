import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../controllers/home_controller.dart';

class CarouselWidget extends GetView<HomeController> {
  const CarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: controller.padding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VisibilityDetector(
          key: const Key("carousel-widget"),
          onVisibilityChanged: (info) {
            if (info.visibleFraction > 0.1) {
              debugPrint("Carousel is visible ✅");
            } else {
              debugPrint("Carousel is hidden ❌");
            }
          },
          child: CarouselSlider(
            options: CarouselOptions(
              height: 150,
              autoPlay: true,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(seconds: 3),
            ),
            items:
                const [
                  "assets/banner/7677532.jpg",
                  "assets/banner/8392116.jpg",
                ].map((path) {
                  return Image.asset(
                    path,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
