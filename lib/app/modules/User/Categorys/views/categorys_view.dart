import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Model/CategoryResp.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';

import '../controllers/categorys_controller.dart';

class CategorysView extends GetView<CategorysController> {
  const CategorysView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: heading('Category', ''),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isCatLoad.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Row(
          children: [
            // Category List
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(() {
                return ListView.builder(
                  key: Key(controller.selectedCategoryId.value.toString()),
                  itemCount: controller.categoryList.length,
                  itemBuilder: (context, index) {
                    CategoryData model = controller.categoryList[index];
                    bool isSelected =
                        controller.selectedCategoryId.value == model.categoryId;

                    return GestureDetector(
                      onTap: () {
                        controller.selectCategory(model.categoryId);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        margin: const EdgeInsets.only(left: 10, bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          color: isSelected ? Colors.white : Colors.transparent,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: CachedNetworkImage(
                                imageUrl: model.categoryImage,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                errorWidget:
                                    (context, error, stackTrace) => const Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              model.categoryName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight:
                                    isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            // Expanded(
            //   child: Obx(() {
            //     if (!controller.isSubCatLoad.value) {
            //       return const Center(child: CircularProgressIndicator());
            //     }

            //     return controller.subCategoryList.isEmpty
            //         ? const Center(child: Text("No subcategories available"))
            //         : Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 8),
            //           child: GridView.builder(
            //             gridDelegate:
            //                 const SliverGridDelegateWithFixedCrossAxisCount(
            //                   crossAxisCount: 3,
            //                   childAspectRatio: .8,
            //                   crossAxisSpacing: 8,
            //                   mainAxisSpacing: 8,
            //                 ),
            //             itemCount: controller.subCategoryList.length,
            //             itemBuilder: (context, index) {
            //               SubcategoryData model =
            //                   controller.subCategoryList[index];
            //               return InkWell(
            //                 onTap: () {
            //                   Get.toNamed(
            //                     Routes.VENDER_LIST,
            //                     arguments: {"venderid": model.subcategoryId},
            //                   );
            //                   controller.homeController.getVenders(
            //                     model.subcategoryId,
            //                   );
            //                   // Get.toNamed(Routes.VENDER_LIST);
            //                 },
            //                 borderRadius: BorderRadius.circular(12),
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     ClipRRect(
            //                       borderRadius: BorderRadius.circular(25),
            //                       child: CachedNetworkImage(
            //                    imageUrl:
            //                         model.subcategoryImage,
            //                         height: 50,
            //                         width: 50,
            //                         fit: BoxFit.cover,
            //                         errorBuilder:
            //                             (context, error, stackTrace) =>
            //                                 const Icon(
            //                                   Icons.image_not_supported,
            //                                   size: 50,
            //                                   color: Colors.grey,
            //                                 ),
            //                       ),
            //                     ),
            //                     const SizedBox(height: 5),
            //                     Text(
            //                       model.subcategoryName,
            //                       textAlign: TextAlign.center,
            //                       style: const TextStyle(
            //                         fontWeight: FontWeight.w300,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               );
            //             },
            //           ),
            //         );
            //   }),
            // ),
          ],
        );
      }),
    );
  }
}
