import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:servizo_vendor/app/Model/VendorList_resp.dart';
import 'package:servizo_vendor/app/modules/Vendor/VenderBooking/controllers/vender_booking_controller.dart';

class Vendorservicedetailedview extends StatelessWidget {
  final VendorList vendorService;
  final VenderBookingController controller =
      Get.find<VenderBookingController>();

  Vendorservicedetailedview(this.vendorService, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, leading: backButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 46,
                            backgroundColor: Colors.grey.shade200,
                            child: _OptimizedAvatar(
                              imageUrl: vendorService.seviceimage,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(child: _BasicInfoCard(vendor: vendorService)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _ContactCard(vendor: vendorService),
                    const SizedBox(height: 10),
                    _PricingRatingCard(vendor: vendorService),
                    const SizedBox(height: 10),
                    _StatusIDsCard(vendor: vendorService),
                    const SizedBox(height: 10),
                    _DescriptionCard(
                      description: vendorService.vendorDescription,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context, vendorService, controller),
    );
  }
}

class _BasicInfoCard extends StatelessWidget {
  final VendorList vendor;
  const _BasicInfoCard({required this.vendor});

  @override
  Widget build(BuildContext context) {
    return _cardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Basic Information",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _detailRow(
            Icons.person,
            "Vendor Name",
            vendor.vendorName,
            Get.theme.primaryColor,
          ),
          const SizedBox(height: 10),
          _detailRow(
            Icons.category,
            "Category",
            vendor.categoryname,
            Get.theme.primaryColor,
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final VendorList vendor;
  const _ContactCard({required this.vendor});

  @override
  Widget build(BuildContext context) {
    return _cardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Contact Information",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _detailRow(
            Icons.phone,
            "Phone Number",
            vendor.vendorPhone,
            Colors.green.shade600,
          ),
        ],
      ),
    );
  }
}

class _PricingRatingCard extends StatelessWidget {
  final VendorList vendor;
  const _PricingRatingCard({required this.vendor});

  @override
  Widget build(BuildContext context) {
    final double originalPrice = vendor.vendorPrice * 1.25;
    final double discountPercentage =
        ((originalPrice - vendor.vendorPrice) / originalPrice * 100)
            .roundToDouble();

    return _cardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Pricing & Rating",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "$discountPercentage% OFF",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Get.theme.canvasColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.currency_rupee,
                color: Colors.green.shade600,
                size: 20,
              ),
              const SizedBox(width: 10),
              const Text(
                "Price: ",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                "₹${originalPrice.round()}",
                style: TextStyle(
                  color: Colors.grey.shade500,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "₹${vendor.vendorPrice}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _detailRow(
            Icons.star,
            "Rating",
            "${vendor.vendorRating} / 5 ⭐",
            Colors.amber.shade700,
          ),
        ],
      ),
    );
  }
}

class _StatusIDsCard extends StatelessWidget {
  final VendorList vendor;
  const _StatusIDsCard({required this.vendor});

  @override
  Widget build(BuildContext context) {
    return _cardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Status & System IDs",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _detailRow(
            Icons.check_circle,
            "Status",
            vendor.vendorStatus.toUpperCase(),
            vendor.vendorStatus.toLowerCase() == "active"
                ? Colors.green
                : Colors.red,
          ),
          const SizedBox(height: 10),
          _detailRow(
            Icons.tag,
            "Vendor ID",
            vendor.vendorId.toString(),
            Colors.blue,
          ),
          const SizedBox(height: 10),
          _detailRow(
            Icons.build,
            "Service ID",
            "Service ID not available",
            Colors.blue,
          ),
          const SizedBox(height: 10),
          _detailRow(
            Icons.category_outlined,
            "Category ID",
            vendor.categoryId.toString(),
            Colors.purple,
          ),
          const SizedBox(height: 10),
          _detailRow(
            Icons.subdirectory_arrow_right,
            "Subcategory ID",
            vendor.subcategoryId.toString(),
            Colors.purple,
          ),
        ],
      ),
    );
  }
}

class _DescriptionCard extends StatelessWidget {
  final String description;
  const _DescriptionCard({required this.description});

  @override
  Widget build(BuildContext context) {
    return _cardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "About Vendor",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            description.isNotEmpty ? description : "No description available",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade800,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// Common card container replacement for Neumorphic
Widget _cardContainer({required Widget child}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: child,
  );
}

/// Common detail row
Widget _detailRow(IconData icon, String label, String value, Color iconColor) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: iconColor, size: 20),
      const SizedBox(width: 10),
      Text("$label: ", style: const TextStyle(fontWeight: FontWeight.w600)),
      Expanded(
        child: Text(
          value,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}

/// Optimized avatar widget
class _OptimizedAvatar extends StatelessWidget {
  final String imageUrl;
  const _OptimizedAvatar({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        height: 92,
        width: 92,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder:
              (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.grey[300],
                  width: 92,
                  height: 92,
                ),
              ),
          errorWidget:
              (context, error, stackTrace) => Container(
                alignment: Alignment.center,
                color: Colors.grey.shade200,
                child: const Icon(Icons.person, color: Colors.grey, size: 50),
              ),
        ),
      ),
    );
  }
}

Widget _buildBottomBar(
  BuildContext context,
  VendorList vendorService,
  VenderBookingController controller,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(color: Colors.white),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.grey.shade200,
              foregroundColor: Colors.black87,
            ),
            onPressed: () => Get.back(),
            child: const Text(
              "Back",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    ),
  );
}
