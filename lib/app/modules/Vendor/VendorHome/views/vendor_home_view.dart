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
    return Scaffold(
      appBar: AppBar(elevation: 0, toolbarHeight: 0),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.getVendorList(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildHeader(),

                  const SizedBox(height: 20),
                  const VendorHomeBody(),
                  const SizedBox(height: 24),
                  _buildCarousel(),
                  const SizedBox(height: 24),
                  _buildVendorListTitle(),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Get.theme.canvasColor,
      ),
      padding: const EdgeInsets.all(10),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                userInfo?.name ?? "Vendor",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("Jasola Vihar - New Delhi", style: TextStyle(fontSize: 14)),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => Get.toNamed(Routes.ADD_VENDER_SERVICE),
                icon: const Icon(CupertinoIcons.add, size: 24),
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.bell, size: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    final banners = ["assets/banner/7677532.jpg", "assets/banner/8392116.jpg"];
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: CarouselSlider(
        options: CarouselOptions(
          scrollDirection: Axis.vertical,
          height: 180,
          autoPlay: true,
          viewportFraction: 1,
          enlargeCenterPage: true,
        ),
        items:
            banners.map((path) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  path,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildVendorListTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "My Services",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVendorCard(VendorList vendor) {
    return InkWell(
      onTap: () => Get.to(Vendorservicedetailedview(vendor)),
      child: Column(
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: vendor.seviceimage,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorWidget:
                          (_, __, ___) =>
                              const Icon(Icons.broken_image, size: 40),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vendor.vendorName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          vendor.categoryname,
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          vendor.vendorDescription,
                          style: const TextStyle(fontSize: 13),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "₹ ${vendor.vendorPrice}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VendorHomeBody extends StatelessWidget {
  const VendorHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          child: Row(
            children: [
              Icon(CupertinoIcons.search),
              SizedBox(width: 10),
              AnimatedSearchHints(),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedSearchHints extends StatelessWidget {
  const AnimatedSearchHints({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      repeatForever: true,
      pause: const Duration(milliseconds: 1000),
      animatedTexts: [
        TyperAnimatedText("Search for services...", textStyle: _textStyle),
        TyperAnimatedText(
          "Find government documents...",
          textStyle: _textStyle,
        ),
        TyperAnimatedText("Check license status...", textStyle: _textStyle),
        TyperAnimatedText("Apply for a passport...", textStyle: _textStyle),
      ],
    );
  }

  static const TextStyle _textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: Colors.grey,
  );
}
