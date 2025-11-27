import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import '../controllers/vender_list_controller.dart';

class BookingForm extends StatelessWidget {
  final int vendorID;
  final int serviceID;
  BookingForm({super.key, required this.vendorID, required this.serviceID});

  final controller = Get.find<VenderListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: backButton(),
        title: heading('Book Vendor', ''),
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBar: _buildConfirmBottomBar(
        context,
        serviceID: serviceID,
        vendorID: vendorID,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel("Select Date"),
                  const SizedBox(height: 8),
                  datePicker(),
                  const SizedBox(height: 20),

                  _sectionLabel("Booking Details"),
                  const SizedBox(height: 8),

                  textbox(
                    controller: controller.bookfor,
                    icon: Icons.task,
                    hinttext: 'Book for',
                    validator: simpleValidator,
                  ),
                  const SizedBox(height: 12),

                  textbox(
                    controller: controller.street,
                    icon: Icons.streetview,
                    hinttext: 'Street, Landmark',
                    validator: simpleValidator,
                  ),
                  const SizedBox(height: 12),

                  textbox(
                    controller: controller.alternatePhone,
                    icon: Icons.phone,
                    hinttext: 'Alternate Phone',
                    validator: simpleValidator,
                  ),
                  const SizedBox(height: 12),

                  textbox(
                    controller: controller.city,
                    icon: Icons.location_city,
                    hinttext: 'City, State',
                    validator: simpleValidator,
                  ),
                  const SizedBox(height: 12),

                  textbox(
                    controller: controller.zipcode,
                    icon: Icons.location_on,
                    hinttext: 'Zip Code',
                    validator: simpleValidator,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static String? simpleValidator(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    if (value.length < 3) return 'Enter at least 3 characters';
    return null;
  }

  Widget textbox({
    TextEditingController? controller,
    required IconData icon,
    String? hinttext,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey.shade600),
        hintText: hinttext,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
      ),
    );
  }

  Widget datePicker() {
    final now = DateTime.now();
    return CupertinoCalendar(
      mainColor: Get.theme.primaryColor,
      minimumDateTime: now,
      maximumDateTime: now.add(const Duration(days: 31)),
      initialDateTime: now,
      currentDateTime: now,
      onDateSelected: (date) {
        controller.lastDate = date;
      },
    );
  }

  Widget _buildConfirmBottomBar(
    BuildContext context, {
    required int serviceID,
    required int vendorID,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Get.back(),
              child: const Text(
                "Back",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
              ),
              onPressed: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.booking(
                    serviceId: serviceID,
                    vendorID: vendorID,
                    context: context,
                  );
                }
              },
              child: Text(
                "Confirm Booking",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}
