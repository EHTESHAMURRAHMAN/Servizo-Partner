import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:servizo_vendor/app/Model/BookingModel.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/modules/User/MyBookings/controllers/my_bookings_controller.dart';

// ignore: must_be_immutable
class EditBooking extends StatelessWidget {
  final controller = Get.find<MyBookingsController>();
  UserBookingData booking;
  EditBooking(this.booking, {super.key});

  @override
  Widget build(BuildContext context) {
    controller.bookfor.text = booking.bookFor;
    controller.street.text = booking.street;
    controller.alternatePhone.text = booking.alternatePhone.toString();
    controller.city.text = booking.city;
    controller.zipcode.text = booking.zipCode;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: backButton(),
        title: heading('Edit Booking', ''),
        centerTitle: true,
      ),
      bottomNavigationBar: _buildConfirmBottomBar(context, booking),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                datePicker(booking.lastDate),
                const SizedBox(height: 10),
                textbox(controller: controller.bookfor, hinttext: 'Book For'),
                const SizedBox(height: 10),
                textbox(
                  controller: controller.street,
                  hinttext: 'Street, Landmark',
                ),
                const SizedBox(height: 10),
                textbox(
                  controller: controller.alternatePhone,
                  hinttext: 'Alternate Phone',
                ),
                const SizedBox(height: 10),
                textbox(controller: controller.city, hinttext: 'City, State'),
                const SizedBox(height: 10),
                textbox(controller: controller.zipcode, hinttext: 'Zip Code'),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textbox({
    required TextEditingController controller,
    String? hinttext,
  }) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(CupertinoIcons.search, color: Get.theme.hintColor),
        hintText: hinttext,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget datePicker(DateTime date) {
    final controller = Get.find<MyBookingsController>();
    final bookedDate = date;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        width: Get.width,
        child: CupertinoCalendar(
          mainColor: const Color(0xff92B6AC),
          minimumDateTime: DateTime(
            bookedDate.year,
            bookedDate.month,
            bookedDate.day,
          ),
          maximumDateTime: DateTime(
            bookedDate.year,
            bookedDate.month,
            bookedDate.day + 31,
          ),
          initialDateTime: bookedDate,
          currentDateTime: bookedDate,
          onDateSelected: (date) {
            controller.lastDate = date;
            print(controller.lastDate);
          },
        ),
      ),
    );
  }
}

Widget _buildConfirmBottomBar(BuildContext context, UserBookingData booking) {
  MyBookingsController myBookingsController = Get.find<MyBookingsController>();

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, -2),
        ),
      ],
    ),
    child: Row(
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
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Get.theme.primaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              myBookingsController.editBookingData(booking);
            },
            child: const Text(
              "Edit Booking",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
