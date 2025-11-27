import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/modules/AddKhataClients/controllers/add_khata_clients_controller.dart';

class AddKhataClientsView extends GetView<AddKhataClientsController> {
  const AddKhataClientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: backButton(),
        title: heading('Add Client', ''),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Get.theme.canvasColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  label: "Firm Name",
                  controller: controller.firmNameController,
                  validator:
                      (val) =>
                          val == null || val.isEmpty ? "Enter Firm Name" : null,
                ),
                _buildTextField(
                  label: "Proprietor Name",
                  controller: controller.proprietorNameController,
                  validator:
                      (val) =>
                          val == null || val.isEmpty
                              ? "Enter Proprietor Name"
                              : null,
                ),
                _buildTextField(
                  label: "Mobile Number",
                  controller: controller.mobileController,
                  keyboardType: TextInputType.phone,
                  validator: (val) {
                    if (val == null || val.isEmpty)
                      return "Enter Mobile Number";
                    if (val.length != 10) return "Enter valid 10-digit number";
                    return null;
                  },
                ),
                _buildTextField(
                  label: "Address",
                  controller: controller.addressController,
                  maxLines: 2,
                  validator:
                      (val) =>
                          val == null || val.isEmpty ? "Enter Address" : null,
                ),
                _buildTextField(
                  label: "Pin Code",
                  controller: controller.pinCodeController,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val == null || val.isEmpty) return "Enter Pin Code";
                    if (val.length != 6) return "Enter valid 6-digit Pin Code";
                    return null;
                  },
                ),
                _buildTextField(
                  label: "GSTIN (Optional)",
                  controller: controller.gstinController,
                  validator: (val) {
                    if (val != null && val.isNotEmpty && val.length != 15) {
                      return "GSTIN must be 15 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Center(
                  child: SizedBox(
                    width: Get.width / 2,
                    child: ElevatedButton(
                      onPressed: controller.addKhataClient,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 3,
                        backgroundColor: Get.theme.primaryColor,
                      ),
                      child: Text(
                        "Save Client",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontWeight: FontWeight.w400),
          filled: true,
          fillColor: Get.theme.scaffoldBackgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
