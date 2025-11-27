import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:servizo_vendor/app/Model/BookingModel.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/modules/User/MyBookings/controllers/my_bookings_controller.dart';

class BookingDetailsView extends StatelessWidget {
  final UserBookingData booking;
  final MyBookingsController controller = Get.find<MyBookingsController>();

  BookingDetailsView({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: backButton(),
        automaticallyImplyLeading: false,
        title: heading(booking.categoryName, ''),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildContent(context),
          const SizedBox(height: 10),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVendorCard(),
          const SizedBox(height: 10),
          _buildDateAndStatusResponsive(),
          const SizedBox(height: 10),
          _buildBookingDetailsCard(),
          const SizedBox(height: 10),
          if (booking.bookFor.isNotEmpty) _descriptionCard(booking.bookFor),
        ],
      ),
    );
  }

  Widget _buildVendorCard() {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: Get.arguments['heroTag'] ?? '',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 130,
                  width: 100,
                  imageUrl: booking.seviceimage,
                  placeholder:
                      (_, __) => Container(
                        color: Colors.grey.shade100,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                  errorWidget:
                      (_, __, ___) => Container(
                        color: Colors.grey.shade100,
                        child: Icon(
                          Icons.person_outline,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                      ),
                ),
              ),
            ),

            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    booking.categoryName,
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                  ),
                  if (booking.serviceDescription.trim().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        booking.serviceDescription,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.phone, color: Get.theme.primaryColor, size: 26),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateAndStatusResponsive() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final widgets = [
          _dateBox("Booking Date", DateTime.tryParse(booking.bookingDate)),
          _dateBox("Last Date", DateTime.tryParse(booking.lastDate.toString())),
          _statusBox(
            getStatus(booking.status),
            bookingStatusIcon(booking.status),
          ),
        ];

        if (constraints.maxWidth < 370) {
          return Column(
            children:
                widgets
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: e,
                      ),
                    )
                    .toList(),
          );
        }
        return Row(
          children:
              widgets
                  .map(
                    (e) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: e,
                      ),
                    ),
                  )
                  .toList(),
        );
      },
    );
  }

  Widget _dateBox(String label, DateTime? date) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Get.theme.canvasColor,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(
            date != null ? DateFormat.yMMMd().format(date) : '-',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _statusBox(String statusLabel, IconData iconData) {
    final isCompleted = statusLabel.toLowerCase().contains("completed");
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color:
            isCompleted
                ? Colors.green.withOpacity(.1)
                : Get.theme.primaryColor.withOpacity(.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isCompleted ? Colors.green : Get.theme.primaryColor,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 26,
            color: isCompleted ? Colors.green : Get.theme.primaryColor,
          ),
          const SizedBox(height: 5),
          Text(
            statusLabel,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isCompleted ? Colors.green : Get.theme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDetailsCard() {
    return Card(
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Booking Details",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),

            const SizedBox(height: 10),
            _detailRow(Icons.phone, "Phone", booking.phoneno),
            const SizedBox(height: 10),
            _detailRow(
              Icons.phone,
              "Alternate Phone",
              booking.alternatePhone ?? '-',
            ),
            const SizedBox(height: 10),
            _detailRow(
              Icons.location_on,
              "Address",
              controller.getFullAddress(
                booking.street,
                booking.city,
                booking.zipCode,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Get.theme.primaryColor, size: 20),
        const SizedBox(width: 10),
        SizedBox(
          width: 95,
          child: Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _descriptionCard(String description) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: Get.theme.canvasColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.description, size: 20, color: Colors.black54),
              SizedBox(width: 8),
              Text(
                "Description",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description.isNotEmpty ? description : "No description provided.",
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final canCancel = booking.status == 0 || booking.status == 3;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Get.back(),
              child: const Text(
                "Back",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (canCancel) ...[
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  await controller.updateBookingData(
                    bookingId: booking.bookingID,
                    statusType: "User",
                  );
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String getStatus(int status) {
    const statusList = [
      'Pending',
      "Cancelled By Vendor",
      "Cancelled By User",
      "Approved By Vendor",
      "Completed",
    ];
    return (status >= 0 && status < statusList.length)
        ? statusList[status]
        : 'Unknown';
  }

  IconData bookingStatusIcon(int status) {
    switch (status) {
      case 0:
        return Icons.pending_actions;
      case 1:
        return Icons.cancel;
      case 2:
        return Icons.cancel_outlined;
      case 3:
        return Icons.check_circle_outline;
      case 4:
        return Icons.verified;
      default:
        return Icons.help_outline;
    }
  }
}
