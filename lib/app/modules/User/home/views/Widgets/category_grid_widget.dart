import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';
import '../../controllers/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class CategoryGridWidget extends GetView<HomeController> {
  const CategoryGridWidget({super.key});

  static const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 10,
    mainAxisSpacing: 14,
    childAspectRatio: 0.9,
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final categories = controller.categoryList;
      if (categories.isEmpty) {
        return _buildShimmerGrid();
      }
      return SliverToBoxAdapter(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = _gridDelegate.crossAxisCount;
            final rowCount = (categories.length / crossAxisCount).ceil();
            final availableWidth = constraints.maxWidth;
            final itemWidth =
                (availableWidth - _gridDelegate.crossAxisSpacing) /
                crossAxisCount;
            final itemHeight = itemWidth / _gridDelegate.childAspectRatio;
            final gridHeight =
                (rowCount * itemHeight) +
                (rowCount - 13.5) * _gridDelegate.mainAxisSpacing;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: gridHeight,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/scrap.png', height: 50),
                      const SizedBox(height: 8),
                      Text(
                        "Sell Your Scrap",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Get best price for your old items",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                      Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 36),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed(Routes.SCRAP);
                        },
                        child: const Text(
                          "Sell Now",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: gridHeight,
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: _gridDelegate,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        final model = categories[index];
                        return _CategoryItem(
                          name: model.categoryName,
                          imageUrl: model.categoryImage,
                          onTap: () async {
                            await controller.getVenders(model.categoryId);
                            Get.toNamed(Routes.VENDER_LIST);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    });
  }

  SliverGrid _buildShimmerGrid() {
    return SliverGrid(
      gridDelegate: _gridDelegate,
      delegate: SliverChildBuilderDelegate(
        (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        childCount: 6,
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.name,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final boxDecoration = BoxDecoration(
      color: Get.theme.primaryColor.withValues(alpha: .2),
      borderRadius: BorderRadius.circular(18),
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: boxDecoration,

        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Get.theme.primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(color: Colors.grey),
                      ),
                  errorWidget:
                      (context, url, error) =>
                          const Icon(Icons.error, size: 40, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
