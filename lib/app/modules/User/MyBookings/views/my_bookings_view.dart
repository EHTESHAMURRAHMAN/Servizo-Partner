import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Model/BookingModel.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/modules/User/MyBookings/views/booking_details_view.dart';
import '../controllers/my_bookings_controller.dart';

class MyBookingsView extends GetView<MyBookingsController> {
  const MyBookingsView({super.key});

  @override
  MyBookingsController get controller => Get.find<MyBookingsController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                heading('My Bookings', ''),
                const SizedBox(height: 16),
                _buildTabBar(),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: tabs.map((tab) => _buildTabContent(tab)).toList(),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      isScrollable: false,

      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      labelColor: Get.theme.primaryColor,
      unselectedLabelColor: Colors.grey.shade700,
      tabs:
          tabs
              .map(
                (tab) => Tab(
                  child: Text(
                    tab,
                    style: const TextStyle(fontFamily: 'Roboto'),
                  ),
                ),
              )
              .toList(),
    );
  }

  Widget _buildTabContent(String tabType) {
    return RefreshIndicator(
      onRefresh: controller.getBookedData,
      color: Colors.blue.shade700,
      child: Obx(() {
        final filtered =
            controller.bookingData
                .where((b) => _filterBooking(b, tabType))
                .toList()
              ..sort(
                (a, b) => b.bookingDate.compareTo(a.bookingDate),
              ); // 🔹 latest first

        if (filtered.isEmpty) {
          return noData();
        }

        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemCount: filtered.length,
          itemBuilder: (_, index) {
            final booking = filtered[index];
            return _BookingCard(
              heroTag: 'booking-${booking.bookingID}',
              booking: booking,
              statusText: controller.getStatus(booking.status),
              onCancel: () {},
            );
          },
        );
      }),
    );
  }

  bool _filterBooking(UserBookingData booking, String tabType) {
    switch (tabType) {
      case "Pending":
        return booking.status == 0;
      case "Cancelled":
        return booking.status == 1 || booking.status == 2;
      case "Approved":
        return booking.status == 3;
      case "Completed":
        return booking.status == 4;
      default:
        return false;
    }
  }
}

class _BookingCard extends StatelessWidget {
  final UserBookingData booking;
  final String statusText;
  final VoidCallback onCancel;
  final String heroTag;

  const _BookingCard({
    required this.booking,
    required this.statusText,
    required this.onCancel,
    required this.heroTag,
  });

  static final _statusColors = [
    Colors.amber.shade100,
    Colors.red.shade100,
    Colors.teal.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    final statusColor =
        (booking.status >= 0 && booking.status < _statusColors.length)
            ? _statusColors[booking.status]
            : Colors.grey.shade300;

    return GestureDetector(
      onTap:
          () => Get.to(
            () => BookingDetailsView(booking: booking),
            transition: Transition.cupertino,
            duration: const Duration(milliseconds: 300),
            arguments: {"heroTag": heroTag},
          ),
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Get.theme.primaryColor, width: .5),
            color: Get.theme.canvasColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildImage(heroTag), _buildDetails(statusColor)],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(heroTag) {
    return Expanded(
      child: Hero(
        tag: heroTag,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: CachedNetworkImage(
            imageUrl: booking.seviceimage,
            fit: BoxFit.cover,
            width: double.infinity,
            placeholder:
                (_, __) => Container(
                  color: Colors.grey.shade100,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
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
    );
  }

  Widget _buildDetails(Color statusColor) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            booking.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),

          Text(
            booking.categoryName,
            style: TextStyle(fontSize: 14, color: Get.theme.hintColor),
          ),

          Text(
            "Date: ${booking.bookingDate.toString().substring(0, 10)}",
            style: TextStyle(fontSize: 13, color: Get.theme.hintColor),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(child: _buildStatusBadge(statusColor)),
              SizedBox(width: 5),
              CancelBookingButton(status: booking.status, onCancel: onCancel),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(Color statusColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          statusText == "Completed"
              ? Icon(Icons.verified, color: Colors.green)
              : SizedBox.shrink(),
          Expanded(
            child: Text(
              statusText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CancelBookingButton extends StatelessWidget {
  final int status;
  final VoidCallback onCancel;

  const CancelBookingButton({
    super.key,
    required this.status,
    required this.onCancel,
  });

  bool get _canCancel => status == 0 || status == 3;

  @override
  Widget build(BuildContext context) {
    if (!_canCancel) return const SizedBox.shrink();

    return InkWell(
      onTap: () => _confirmCancel(context),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.red.shade900,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(Icons.cancel_outlined, color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _confirmCancel(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black54,
      builder:
          (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.white,
            title: const Text(
              'Cancel Booking?',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            content: const Text(
              'Are you sure you want to cancel this booking?',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text(
                  'No',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                child: const Text(
                  'Yes',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ],
          ),
    );
    if (confirm == true) onCancel();
  }
}

const tabs = ["Pending", "Cancelled", "Approved", "Completed"];
