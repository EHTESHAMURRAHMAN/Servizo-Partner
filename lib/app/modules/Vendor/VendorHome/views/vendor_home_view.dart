import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Api/Base_Api.dart';
import 'package:servizo_vendor/app/Model/VendorList_resp.dart';
import 'package:servizo_vendor/app/modules/Vendor/VendorHome/views/VendorServiceDetailedView.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';

import '../controllers/vendor_home_controller.dart';

class VendorHomeView extends GetView<VendorHomeController> {
  const VendorHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: theme.primaryColor,
          onRefresh: () => controller.getVendorList(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 18),
                  _buildHeader(theme),

                  const SizedBox(height: 18),
                  const VendorHomeSearchBox(),

                  const SizedBox(height: 20),
                  _buildCarousel(),

                  const SizedBox(height: 26),
                  _buildVendorListTitle(),

                  const SizedBox(height: 12),
                  Obx(() {
                    if (!controller.isVendorList.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (controller.vendorList.isEmpty) {
                      return const Text("No vendors available at the moment.");
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.vendorList.length,
                      itemBuilder: (context, index) {
                        final vendor = controller.vendorList[index];
                        return _buildVendorCard(vendor);
                      },
                    );
                  }),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _buildHeader(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.05)),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // User Avatar
          CircleAvatar(
            radius: 26,
            backgroundColor: theme.primaryColor.withOpacity(0.1),
            child: Icon(
              CupertinoIcons.person_fill,
              size: 26,
              color: theme.primaryColor,
            ),
          ),

          const SizedBox(width: 14),

          // Name + Location
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userInfo?.name ?? "Vendor",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Jasola Vihar - New Delhi",
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          // Buttons
          Row(
            children: [
              IconButton(
                onPressed: () => Get.toNamed(Routes.ADD_VENDER_SERVICE),
                icon: Icon(
                  CupertinoIcons.add_circled_solid,
                  size: 26,
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.bell_fill,
                  size: 22,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- CAROUSEL ----------------
  Widget _buildCarousel() {
    final banners = ["assets/banner/banner1.png", "assets/banner/banner2.png"];

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          viewportFraction: 1,
          height: 170,
          autoPlayCurve: Curves.easeInOut,
        ),
        items:
            banners.map((path) {
              return Image.asset(
                path,
                fit: BoxFit.cover,
                width: double.infinity,
              );
            }).toList(),
      ),
    );
  }

  // ---------------- TITLE: My Services ----------------
  Widget _buildVendorListTitle() {
    return const Text(
      "My Services",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  // ---------------- SERVICE CARD ----------------
  Widget _buildVendorCard(VendorList vendor) {
    return InkWell(
      onTap: () => Get.to(Vendorservicedetailedview(vendor)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, 3),
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: CachedNetworkImage(
                imageUrl: vendor.seviceimage,
                width: 90,
                height: 100,
                fit: BoxFit.cover,
                errorWidget:
                    (_, __, ___) => const Icon(Icons.broken_image, size: 40),
              ),
            ),

            const SizedBox(width: 12),

            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vendor.vendorName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),

                    Text(
                      vendor.categoryname,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      vendor.vendorDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13, height: 1.3),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "₹ ${vendor.vendorPrice}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------------------
// SEARCH BOX
// --------------------------------------------------------------

class VendorHomeSearchBox extends StatelessWidget {
  const VendorHomeSearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: const [
            Icon(CupertinoIcons.search, size: 22),
            SizedBox(width: 12),
            Expanded(child: AnimatedSearchHints()),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------------------
// SEARCH HINTS ANIMATION
// --------------------------------------------------------------

class AnimatedSearchHints extends StatelessWidget {
  const AnimatedSearchHints({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      repeatForever: true,
      pause: const Duration(milliseconds: 1200),
      animatedTexts: [
        TyperAnimatedText("Search for services...", textStyle: _style),
        TyperAnimatedText("Find government documents...", textStyle: _style),
        TyperAnimatedText("Check license status...", textStyle: _style),
        TyperAnimatedText("Apply for a passport...", textStyle: _style),
      ],
    );
  }

  static const _style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
}
