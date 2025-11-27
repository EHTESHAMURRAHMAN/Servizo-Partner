import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:servizo_vendor/app/Model/VenderBooking.dart';
import 'package:servizo_vendor/app/modules/Vendor/VenderBooking/controllers/vender_booking_controller.dart';
import 'package:servizo_vendor/app/modules/Vendor/VenderBooking/views/vendor_detailed_booking_view.dart';

class VenderBookingView extends GetView<VenderBookingController> {
  const VenderBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Bookings",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Cancelled'),
              Tab(text: 'Accepted'),
              Tab(text: 'Completed'),
            ],
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            labelColor: Colors.blueAccent,
            unselectedLabelStyle: TextStyle(fontSize: 14),
            unselectedLabelColor: Colors.grey,
            indicatorWeight: 2,
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabContent(context, 'Pending'),
            _buildTabContent(context, 'Cancelled'),
            _buildTabContent(context, 'Approved'),
            _buildTabContent(context, 'Completed'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, String tabType) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.getBookedData();
      },
      child: Obx(() {
        if (!controller.isBookingDataLoad.value) {
          return const Center(child: CircularProgressIndicator());
        }

        List<VendorBookingData> filteredBookings;
        switch (tabType) {
          case 'Pending':
            filteredBookings =
                controller.bookingData.where((b) => b.status == 0).toList();
            break;
          case 'Cancelled':
            filteredBookings =
                controller.bookingData
                    .where((b) => b.status == 1 || b.status == 2)
                    .toList();
            break;
          case "Approved":
            filteredBookings =
                controller.bookingData.where((b) => b.status == 3).toList();
            break;
          case 'Completed':
            filteredBookings =
                controller.bookingData.where((b) => b.status == 4).toList();
            break;
          default:
            filteredBookings = [];
        }

        if (filteredBookings.isEmpty) {
          return Center(
            child: Text(
              "No $tabType bookings found!",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filteredBookings.length,
          itemBuilder: (context, index) {
            return _buildBookingCard(filteredBookings[index], context);
          },
        );
      }),
    );
  }

  Widget _buildBookingCard(VendorBookingData booking, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Get.to(() => VendorDetailedBookingView(booking)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://static.vecteezy.com/system/resources/thumbnails/066/495/870/small/a-man-in-a-yellow-hard-hat-and-tie-free-photo.jpeg',
                  width: 80,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        width: 80,
                        height: 100,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.image_not_supported, size: 40),
                      ),
                ),
              ),
              const SizedBox(width: 16),

              /// Booking details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text("Booking Date: ${_formatDate(booking.bookingDate)}"),
                    const SizedBox(height: 4),
                    Text("Booking ID: ${booking.bookingID}"),
                    const SizedBox(height: 8),
                    _buildStatusBadge(booking.status),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(int status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 0:
        bgColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;
      case 1:
      case 2:
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;
      case 3:
        bgColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;
      case 4:
        bgColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        break;
      default:
        bgColor = Colors.grey.shade100;
        textColor = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        controller.getStatus(status),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      DateTime date = DateTime.parse(dateStr);
      return DateFormat("dd MMM yyyy, hh:mm a").format(date);
    } catch (_) {
      return "Invalid Date";
    }
  }
}
