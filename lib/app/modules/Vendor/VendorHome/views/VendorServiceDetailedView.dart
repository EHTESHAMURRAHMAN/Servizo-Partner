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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BigTopImage(imageUrl: vendorService.seviceimage),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    _BasicInfoCard_NoIcon(vendor: vendorService),

                    _ContactCard_NoIcon(vendor: vendorService),

                    _PricingCard_NoIcon(vendor: vendorService),

                    _DescriptionCard(
                      description: vendorService.vendorDescription,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BigTopImage extends StatelessWidget {
  final String imageUrl;
  const _BigTopImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder:
                (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(color: Colors.grey[300]),
                ),
            errorWidget:
                (context, error, stackTrace) => Container(
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Icon(Icons.photo, size: 60, color: Colors.grey),
                ),
          ),
        ),
        Padding(padding: const EdgeInsets.all(20.0), child: backButton()),
      ],
    );
  }
}

class _BasicInfoCard_NoIcon extends StatelessWidget {
  final VendorList vendor;
  const _BasicInfoCard_NoIcon({required this.vendor});

  @override
  Widget build(BuildContext context) {
    return _cardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            vendor.vendorName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            vendor.categoryname,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _ContactCard_NoIcon extends StatelessWidget {
  final VendorList vendor;
  const _ContactCard_NoIcon({required this.vendor});

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

          _textRow("Phone Number", vendor.vendorPhone),
        ],
      ),
    );
  }
}

class _PricingCard_NoIcon extends StatelessWidget {
  final VendorList vendor;
  const _PricingCard_NoIcon({required this.vendor});

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
                "Pricing",
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
                    color: Get.theme.canvasColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: [
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
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          _textRow("Rating", "${vendor.vendorRating} / 5"),
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
          const SizedBox(height: 6),
          Text(
            description.isNotEmpty ? description : "No description available",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade800,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _cardContainer({required Widget child}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: child,
  );
}

Widget _textRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label: ", style: const TextStyle(fontWeight: FontWeight.w600)),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    ),
  );
}
