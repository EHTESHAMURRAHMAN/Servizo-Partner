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
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                controller.pageIndex.value = index;
              },
              children: [
                buildPage(
                  "assets/icons/realtor_8373731.png",
                  "Get Services at Your Doorstep",
                  "Find trusted professionals for home services like plumbing, electrical work, beauty, and more—all delivered conveniently to you.",
                  context,
                ),
                buildPage(
                  "assets/icons/expert.png",
                  "Connecting You with Experts",
                  "Easily book skilled professionals and experience hassle-free services tailored to your needs.",
                  context,
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
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.all(6),
                  width: controller.pageIndex.value == index ? 16 : 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color:
                        controller.pageIndex.value == index
                            ? theme.primaryColor
                            : theme.disabledColor.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),

          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (controller.pageIndex.value > 0)
                    IconButton(
                      onPressed: () {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: const Icon(Icons.arrow_back_ios, size: 28),
                      color: Colors.black54,
                    )
                  else
                    const SizedBox(width: 56),

                  controller.pageIndex.value < 2
                      ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(14),
                          backgroundColor: theme.primaryColor,
                        ),
                        onPressed: () {
                          if (controller.pageIndex.value < 2) {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            Get.toNamed(Routes.LOGIN);
                          }
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 28,
                          color: Colors.white,
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
    String image,
    String title,
    String description,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Image.asset(image, height: MediaQuery.of(context).size.height / 4),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildLastPage(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Image.asset(
                'assets/icons/join.png',
                height: MediaQuery.of(context).size.height / 4,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Join Us Today",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.bodyLarge?.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "Are you a skilled professional? Or are you looking for trusted services? Choose your role and get started!",
              style: TextStyle(
                fontSize: 16,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            OutlinedButton(
              onPressed: () => Get.toNamed(Routes.VENDOR_LOGIN),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 50,
                ),
                shape: StadiumBorder(),
              ),
              child: Text(
                "Login as Vendor",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => Get.toNamed(Routes.LOGIN),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 50,
                ),
                shape: StadiumBorder(),
                backgroundColor: theme.primaryColor,
              ),
              child: const Text(
                "Login as User",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
