import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:servizo_vendor/app/Model/VendersResp.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/modules/User/VenderList/views/vendor_details_view.dart';
import '../controllers/vender_list_controller.dart';

class VenderListView extends GetView<VenderListController> {
  const VenderListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: backButton(),
        title: heading('Vendors', ''),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          if (!controller.homeController.isVendersLoad.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.homeController.venderlist.isEmpty) {
            return noData();
          }

          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: controller.homeController.venderlist.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 0.60,
            ),
            itemBuilder: (context, index) {
              final vendor = controller.homeController.venderlist[index];
              return VendorCard(vendor: vendor);
            },
          );
        }),
      ),
    );
  }
}

class VendorCard extends StatelessWidget {
  final VendorData vendor;
  const VendorCard({super.key, required this.vendor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Get.to(() => VendorDetailView(vendor: vendor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Hero(
                tag: 'vendor_${vendor.vendorId}', // unique tag
                child: CachedNetworkImage(
                  width: double.infinity,
                  imageUrl: vendor.seviceimage,
                  fit: BoxFit.cover,
                  placeholder:
                      (_, __) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(color: Colors.grey[300]),
                      ),
                  errorWidget:
                      (_, __, ___) => Container(
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    vendor.vendorName,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    vendor.vendorDescription,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,

                      color: Get.theme.hintColor,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "₹${vendor.vendorPrice.toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,

                          color: theme.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 6),
                      _RatingBadge(rating: vendor.vendorRating),
                    ],
                  ),
                  const SizedBox(height: 6),
                  _StatusBadge(status: vendor.vendorstatus, theme: theme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  final int rating;
  const _RatingBadge({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.amber.withOpacity(0.15),
      ),
      child: Row(
        children: [
          const Icon(Icons.star_rounded, color: Color(0xFFF4B400), size: 17),
          const SizedBox(width: 3),
          Text(
            rating.toString(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              fontFamily: 'Inter',
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  final ThemeData theme;
  const _StatusBadge({required this.status, required this.theme});

  @override
  Widget build(BuildContext context) {
    final isActive = status.toLowerCase() == "active";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color:
            isActive
                ? theme.primaryColor.withOpacity(0.1)
                : Colors.green.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 10),
          Text(
            status.toUpperCase(),
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
              color: isActive ? theme.primaryColor : Colors.green.shade700,
              letterSpacing: 0.7,
            ),
          ),
        ],
      ),
    );
  }
}
