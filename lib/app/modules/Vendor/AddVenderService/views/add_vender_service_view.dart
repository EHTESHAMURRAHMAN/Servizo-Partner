import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import '../controllers/add_vender_service_controller.dart';

class AddVenderServiceView extends GetView<AddVenderServiceController> {
  const AddVenderServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: heading('Add Vendor Service', ''),
        automaticallyImplyLeading: false,
        leading: backButton(),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),

                FormField<int>(
                  validator: (value) {
                    if (controller.selectCategoryID.value == 0) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                  builder:
                      (state) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Obx(
                              () => DropdownButton<int>(
                                isExpanded: true,
                                underline: const SizedBox(),
                                borderRadius: BorderRadius.circular(12),
                                hint: const Text("Select Category"),
                                value:
                                    controller.selectCategoryID.value == 0
                                        ? null
                                        : controller.selectCategoryID.value,
                                items:
                                    controller.categoryList
                                        .map(
                                          (cat) => DropdownMenuItem<int>(
                                            value: cat.categoryId,
                                            child: Text(cat.categoryName),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (value) {
                                  controller.selectCategoryID.value = value!;
                                  controller.getSubCategory(value);
                                  state.didChange(value);
                                },
                              ),
                            ),
                          ),
                          if (state.hasError)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                state.errorText!,
                                style: TextStyle(
                                  color: Colors.red.shade700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                ),

                const SizedBox(height: 20),

                /// Upload Image
                InkWell(
                  onTap: () async {
                    final result = await controller.uploadImage(context);
                    if (result != null) {
                      controller.serviceIMG.value = XFile(result[0]);
                      controller.serviceIMGURL.value = result[1];
                    }
                  },
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Obx(
                          () =>
                              controller.serviceIMG.value == null
                                  ? Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: const Icon(
                                      Icons.cloud_upload_outlined,
                                    ),
                                  )
                                  : Image.file(
                                    File(controller.serviceIMG.value!.path),
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          'Upload Image',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Price field
                TextFormField(
                  controller: controller.price,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Price",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    controller.serviceCharge.value =
                        double.tryParse(value) ?? 0.0;
                  },
                  validator: (value) {
                    if (controller.serviceCharge.value <= 0) {
                      return 'Please enter service charge';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                /// Description field
                TextFormField(
                  controller: controller.description,
                  maxLines: 5,
                  minLines: 1,
                  maxLength: 200,
                  decoration: const InputDecoration(
                    labelText: "Service Description",
                    border: OutlineInputBorder(),
                    hintText: "Enter at least 100 characters",
                  ),
                  validator: (value) {
                    if (value == null || value.trim().length < 100) {
                      return 'Please enter at least 100 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                /// Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.addVendorService,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
