import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Model/VenderBooking.dart';
import 'package:servizo_vendor/app/modules/Vendor/VenderBooking/controllers/vender_booking_controller.dart';

class VendorDetailedBookingView extends StatelessWidget {
  final VendorBookingData booking;
  final VenderBookingController controller =
      Get.find<VenderBookingController>();

  VendorDetailedBookingView(this.booking, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildVendorCard(),
            const SizedBox(height: 12),
            _buildDateAndStatusCard(),
            const SizedBox(height: 12),
            _buildBookingDetailsCard(),
            const SizedBox(height: 12),
            _buildDescriptionCard(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  /// ---------------- Vendor Card ----------------
  Widget _buildVendorCard() {
    return _cardWrapper(
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(booking.seviceimage),
              ),
              const SizedBox(width: 12),
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
                    ),
                    Text(
                      booking.categoryName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              _iconButton(Icons.phone, () {
                /* TODO: Call vendor */
              }),
              _iconButton(Icons.chat, () {
                /* TODO: Chat with vendor */
              }),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            booking.serviceDescription,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  /// ---------------- Date & Status ----------------
  Widget _buildDateAndStatusCard() {
    final bookingDate = DateTime.parse(booking.bookingDate);

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
              icon: Icons.calendar_today,
              label: "Booking Date",
              value:
                  "${bookingDate.day}/${bookingDate.month}/${bookingDate.year}",
            ),
            const Divider(height: 20, thickness: 1),
            _buildInfoRow(
              icon: Icons.event,
              label: "Last Date",
              value: booking.lastDate.toString(),
            ),
            const Divider(height: 20, thickness: 1),
            _buildStatusRow(
              icon: bookingStatusIcon(booking.status),
              status: getStatus(booking.status),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable row for info display
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: Get.theme.primaryColor, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Row for status with highlight
  Widget _buildStatusRow({required IconData icon, required String status}) {
    final isCompleted = status.toLowerCase() == "completed";

    return Row(
      children: [
        Icon(
          icon,
          color: isCompleted ? Colors.green : Get.theme.primaryColor,
          size: 22,
        ),
        const SizedBox(width: 10),
        Text(
          status,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isCompleted ? Colors.green : Get.theme.primaryColor,
          ),
        ),
      ],
    );
  }

  /// ---------------- Booking Details ----------------
  Widget _buildBookingDetailsCard() {
    return _cardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Booking Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 20),
          _detailRow(
            Icons.confirmation_number,
            Colors.blue,
            "Booking ID",
            booking.bookingID.toString(),
          ),
          _detailRow(Icons.phone, Colors.green, "Phone", booking.phoneno),
          _detailRow(
            Icons.phone_forwarded,
            Colors.green,
            "Alternate Phone",
            booking.alternatePhone ?? "N/A",
          ),
          _detailRow(
            Icons.location_city,
            Colors.orange,
            "Address",
            controller.getFullAddress(
              booking.street,
              booking.city,
              booking.zipCode,
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- Description Card ----------------
  Widget _buildDescriptionCard() {
    return _cardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Booking Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            booking.bookFor,
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
        ],
      ),
    );
  }

  /// ---------------- Bottom Bar ----------------
  Widget _buildBottomBar(BuildContext context) {
    final isPending = booking.status == 0;
    final isApproved = booking.status == 3;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          _actionButton(
            "Back",
            Colors.grey.shade200,
            Colors.black,
            () => Get.back(),
          ),
          if (isPending)
            _actionButton("Approve", Get.theme.primaryColor, Colors.white, () {
              controller.updateBookingData(
                bookingId: booking.bookingID,
                statusType: "Approve",
                context: context,
              );
            }),
          if (isApproved)
            _actionButton("Complete", Get.theme.primaryColor, Colors.white, () {
              controller.updateBookingData(
                bookingId: booking.bookingID,
                statusType: "Completed",
                context: context,
              );
            }),
          if (isPending || isApproved)
            _actionButton("Reject", Colors.red.shade400, Colors.white, () {
              controller.onCancelPressed(
                context,
                bookingId: booking.bookingID,
                statusType: "Vendor",
              );
            }),
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, Color color, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(fontSize: 16)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardWrapper({required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, size: 28, color: Get.theme.primaryColor),
    );
  }

  Widget _actionButton(String label, Color bg, Color fg, VoidCallback onTap) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bg,
            foregroundColor: fg,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onTap,
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  /// ---------------- Status Mapping ----------------
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

  String getStatus(int status) {
    const statusList = [
      'Pending',
      "Cancelled By User",
      "Cancelled By Vendor",
      "Approved By Vendor",
      "Completed",
    ];
    return statusList[status];
  }
}
