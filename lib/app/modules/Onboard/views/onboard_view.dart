import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';
import '../controllers/onboard_controller.dart';

class OnboardView extends GetView<OnboardController> {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),

      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) => controller.pageIndex.value = index,
              children: [
                buildPage(
                  context,
                  image: "assets/onboard/onboard1.png",
                  title: "Showcase Your Skills. Deliver Excellence.",
                  description:
                      "Join a trusted platform built for skilled professionals like you. Whether you specialize in AC repair, electrical work, plumbing, appliance servicing, beauty, home cleaning, or any other trade — we help you reach the right customers and grow your business with confidence.",
                ),
                buildPage(
                  context,
                  image: "assets/onboard/onboard2.png",
                  title: "Build Trust With Verified Credentials",
                  description:
                      "Our rigorous verification system ensures every professional meets high standards of quality and reliability. Earn customer trust, build a strong reputation, and receive repeat bookings by delivering exceptional service—every single time.",
                ),
                buildLastPage(context),
              ],
            ),
          ),

          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  margin: const EdgeInsets.all(6),
                  width: controller.pageIndex.value == index ? 22 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:
                        controller.pageIndex.value == index
                            ? theme.primaryColor
                            : Colors.grey.withOpacity(0.4),
                  ),
                ),
              ),
            ),
          ),

          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  controller.pageIndex.value > 0
                      ? IconButton(
                        onPressed: () {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: const Icon(Icons.arrow_back_ios, size: 28),
                        color: Colors.black54,
                      )
                      : const SizedBox(width: 56),

                  controller.pageIndex.value < 2
                      ? GestureDetector(
                        onTap: () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                theme.primaryColor,
                                theme.primaryColor.withOpacity(0.8),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: theme.primaryColor.withOpacity(0.4),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(
    BuildContext context, {
    required String image,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50),

          AnimatedScale(
            duration: const Duration(milliseconds: 500),
            scale: 1,
            child: Image.asset(
              image,
              height: MediaQuery.of(context).size.height / 3.3,
            ),
          ),

          const SizedBox(height: 30),

          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLastPage(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: [
          Image.asset(
            'assets/onboard/onboard3.png',
            height: MediaQuery.of(context).size.height / 3.3,
          ),

          const SizedBox(height: 20),

          Text(
            "Unlock New Opportunities. Earn More.",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: theme.textTheme.bodyLarge?.color,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 10),

          Text(
            "Access new opportunities, manage bookings smoothly, and boost your earnings with a seamless vendor experience.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
            ),
          ),

          Spacer(),
          Obx(
            () => OutlinedButton(
              onPressed: () async {
                controller.isLoading.value = true;
                await Future.delayed(const Duration(milliseconds: 600));
                Get.toNamed(Routes.VENDOR_LOGIN);

                controller.isLoading.value = false;
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 50,
                ),
                shape: const StadiumBorder(),
                side: BorderSide(color: theme.primaryColor, width: 1.5),
              ),
              child:
                  controller.isLoading.value
                      ? TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 600),
                        builder: (context, value, child) {
                          return Transform.rotate(
                            angle: value * 6.3,
                            child: Icon(
                              Icons.sync,
                              color: theme.primaryColor,
                              size: 22,
                            ),
                          );
                        },
                      )
                      : Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: theme.primaryColor,
                        ),
                      ),
            ),
          ),

          Spacer(),
        ],
      ),
    );
  }
}
