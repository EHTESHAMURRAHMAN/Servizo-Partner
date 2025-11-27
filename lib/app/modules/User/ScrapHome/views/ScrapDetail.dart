import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Model/picked_scrap_resp.dart';
import 'package:servizo_vendor/app/modules/User/ScrapHome/controllers/scrap_home_controller.dart';

class ScrapDetailView extends StatelessWidget {
  final PickedScrapData order;
  ScrapDetailView({super.key, required this.order});

  final ScrapHomeController controller = Get.put(ScrapHomeController());

  @override
  Widget build(BuildContext context) {
    final List<String> images = order.items.map((e) => e.scrapImg).toList();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: Get.height / 1.4,
              pinned: true,
              leading: IconButton(
                icon: CircleAvatar(
                  backgroundColor: Get.theme.hintColor,
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                onPressed: () => Get.back(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Obx(
                  () => Text(
                    order.items.isNotEmpty
                        ? order.items[controller.currentIndex.value].scrapType
                        : "Scrap",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Get.theme.canvasColor,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: order.requestId,
                      child: ClipPath(
                        clipper: ConcaveClipper(),
                        child: Stack(
                          children: [
                            PageView.builder(
                              controller: controller.pageController,
                              itemCount: images.length,
                              onPageChanged: (value) => controller.currentIndex,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  images[index],
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, __, ___) => Container(
                                        color: Colors.grey.shade200,
                                        child: const Icon(
                                          Icons.image,
                                          size: 60,
                                          color: Colors.grey,
                                        ),
                                      ),
                                );
                              },
                            ),
                            // Left arrow
                            if (images.length > 1)
                              Positioned(
                                left: 8,
                                top: 0,
                                bottom: 0,
                                child: Center(
                                  child: GestureDetector(
                                    onTap: controller.previousPage,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black38,
                                      child: const Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            // Right arrow
                            if (images.length > 1)
                              Positioned(
                                right: 8,
                                top: 0,
                                bottom: 0,
                                child: Center(
                                  child: GestureDetector(
                                    onTap:
                                        () =>
                                            controller.nextPage(images.length),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black38,
                                      child: const Icon(
                                        Icons.arrow_forward_ios,
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
                    // indicator dots
                    if (images.length > 1)
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(images.length, (index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                width:
                                    controller.currentIndex.value == index
                                        ? 12
                                        : 8,
                                height:
                                    controller.currentIndex.value == index
                                        ? 12
                                        : 8,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(
                                    controller.currentIndex.value == index
                                        ? 0.9
                                        : 0.5,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            /// Thumbnails
            SliverToBoxAdapter(
              child: SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => controller.changePage(index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                controller.currentIndex.value == index
                                    ? Get.theme.primaryColor
                                    : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            images[index],
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (_, __, ___) => Container(
                                  color: Colors.grey.shade200,
                                  child: const Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                  ),
                                ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            /// Details section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _detailRow(
                      "Customer",
                      order.fullName,
                      Icons.person,
                      Colors.grey.shade600,
                    ),
                    _detailRow(
                      "Pickup Date",
                      order.pickupDate,
                      Icons.calendar_today,
                      Colors.grey.shade600,
                    ),
                    _detailRow(
                      "Address",
                      order.pickupAddress,
                      Icons.location_on,
                      Colors.redAccent,
                      multiLine: true,
                    ),
                    _detailRow(
                      "Phone",
                      order.phoneNumber,
                      Icons.phone,
                      Colors.blueAccent,
                    ),
                    const SizedBox(height: 10),
                    _statusBadge(order.status, order.isPaid),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(
    String label,
    String value,
    IconData icon,
    Color color, {
    bool multiLine = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment:
            multiLine ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500,
                    letterSpacing: 0.7,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(String status, bool isPaid) {
    Color bg, border, textColor;
    if (status == "Completed") {
      bg = Colors.green.shade50;
      border = Colors.green.shade300;
      textColor = Colors.green.shade700;
    } else if (status == "Pending") {
      bg = Colors.orange.shade50;
      border = Colors.orange.shade300;
      textColor = Colors.orange.shade700;
    } else {
      bg = Colors.red.shade50;
      border = Colors.red.shade300;
      textColor = Colors.red.shade700;
    }
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              status,
              style: TextStyle(fontWeight: FontWeight.w600, color: textColor),
            ),
            const SizedBox(width: 6),
            Icon(
              isPaid ? Icons.verified : Icons.pending,
              color: isPaid ? Colors.green : Colors.red,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class ConcaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
