import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import '../controllers/scrap_booking_controller.dart';

class ScrapBookingView extends GetView<ScrapBookingController> {
  const ScrapBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: backButton(),
        title: heading('Book Scrap Pickup', ''),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle(Icons.person, "Personal Details"),
                _inputCard(
                  child: _formField(
                    label: "Full Name",
                    controller: controller.nameController,
                    validator: (v) => v!.isEmpty ? "Enter your name" : null,
                  ),
                ),
                const SizedBox(height: 4),
                _inputCard(
                  child: _formField(
                    label: "Phone Number",
                    controller: controller.phoneController,
                    keyboardType: TextInputType.phone,
                    validator:
                        (v) =>
                            v!.length < 10 ? "Enter valid phone number" : null,
                  ),
                ),
                const SizedBox(height: 20),

                _sectionTitle(Icons.home, "Pickup Information"),
                _inputCard(
                  child: _formField(
                    label: "Pickup Address",
                    controller: controller.addressController,
                    maxLines: 3,
                    validator:
                        (v) => v!.isEmpty ? "Enter pickup address" : null,
                  ),
                ),
                const SizedBox(height: 4),
                _inputCard(
                  child: _formField(
                    label: "Preferred Pickup Date",
                    controller: controller.dateController,
                    readOnly: true,
                    onTap: () => controller.pickDate(context),
                    validator: (v) => v!.isEmpty ? "Select pickup date" : null,
                  ),
                ),
                const SizedBox(height: 20),

                _sectionTitle(Icons.photo_library, "Scrap Items"),
                _scrapItemList(context),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.pickupScrap();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: theme.primaryColor,
                      elevation: 2,
                    ),
                    child: const Text(
                      "Confirm Booking",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Get.theme.primaryColor, size: 20),
          const SizedBox(width: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  /// Card wrapper for inputs
  Widget _inputCard({required Widget child}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: child,
      ),
    );
  }

  /// Reusable Form Field
  Widget _formField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    int maxLines = 1,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
    VoidCallback? onTap,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      readOnly: readOnly,
      keyboardType: keyboardType,
      validator: validator,
      onTap: onTap,
      decoration: InputDecoration(labelText: label, border: InputBorder.none),
    );
  }

  /// Scrap Item List + Add Button
  Widget _scrapItemList(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          // Items preview
          if (controller.items.isEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.centerLeft,
              child: const Text("No items added yet"),
            )
          else
            Column(
              children:
                  controller.items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value; // ScrapItem

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: _buildItemImage(item),
                        ),
                        title: Text(item.scrapType),
                        subtitle: Text("Item ID: ${item.itemId}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => controller.removeItem(index),
                        ),
                      ),
                    );
                  }).toList(),
            ),

          const SizedBox(height: 8),

          // Add item button
          OutlinedButton.icon(
            onPressed: () async {
              // 1) pick scrap type (modal bottom sheet)
              final selectedType = await showModalBottomSheet<String>(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (ctx) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          controller.scrapTypes.map((type) {
                            return ListTile(
                              title: Text(type),
                              onTap: () => Navigator.pop(ctx, type),
                            );
                          }).toList(),
                    ),
                  );
                },
              );

              if (selectedType == null) return;

              // 2) upload image (controller handles crop/compress/upload)
              List? file = await controller.uploadImage(context);
              if (file == null || file.length < 2) {
                // user cancelled upload
                return;
              }

              // file[0] = localPath, file[1] = serverUrl/requestnumber
              final String localPath = file[0];
              final String serverUrl = file[1];

              // 3) Add to controller using helper (keeps counter in controller)
              controller.addItemFromUpload(
                scrapType: selectedType,
                localPath: localPath,
                serverUrl: serverUrl,
              );
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Scrap Item"),
          ),
        ],
      ),
    );
  }

  Widget _buildItemImage(dynamic item) {
    final ScrapItem scrap = item as ScrapItem;

    if (scrap.localPath != null && scrap.localPath!.isNotEmpty) {
      final f = File(scrap.localPath!);
      if (f.existsSync()) {
        return Image.file(f, width: 50, height: 50, fit: BoxFit.cover);
      }
    }

    if (scrap.scrapImg.isNotEmpty) {
      return Image.network(
        scrap.scrapImg,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder:
            (_, __, ___) => const SizedBox(
              width: 50,
              height: 50,
              child: Icon(Icons.broken_image),
            ),
      );
    }

    return const SizedBox(width: 50, height: 50, child: Icon(Icons.image));
  }
}
