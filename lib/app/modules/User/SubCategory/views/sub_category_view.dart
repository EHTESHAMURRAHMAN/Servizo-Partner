import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Model/subCategoryResp.dart';
import '../controllers/sub_category_controller.dart';

class SubCategoryView extends GetView<SubCategoryController> {
  const SubCategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SubCategoryView'), centerTitle: true),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.homeController.subCategoryList.length,
          itemBuilder: (context, index) {
            SubcategoryData model = controller.homeController.subCategoryList
                .elementAt(index);
            return InkWell(
              child: InkWell(
                onTap: () async {},
                child: SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      CachedNetworkImage(imageUrl: model.subcategoryImage),
                      Text(model.subcategoryName),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
