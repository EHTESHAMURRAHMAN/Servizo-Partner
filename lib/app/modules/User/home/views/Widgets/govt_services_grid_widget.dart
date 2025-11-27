import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/home_controller.dart';

class GovtServicesGridWidget extends GetView<HomeController> {
  const GovtServicesGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final services = controller.govtServices;

    if (services.isEmpty) {
      return noData();
    }

    return SliverMasonryGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 11,
      crossAxisSpacing: 11,
      childCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        final isLarge = index % 4 == 0;

        return _GovtServiceCard(
          name: service["name"] ?? "Unknown",
          iconUrl: service["icon"] ?? "",
          url: service["url"] ?? "",
          isLarge: isLarge,
        );
      },
    );
  }
}

class _GovtServiceCard extends StatelessWidget {
  final String name;
  final String iconUrl;
  final String url;
  final bool isLarge;

  const _GovtServiceCard({
    required this.name,
    required this.iconUrl,
    required this.url,
    required this.isLarge,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Get.theme.primaryColor.withOpacity(.2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () async {
            final Uri uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
          child: SizedBox(
            height: isLarge ? 200 : 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                ClipRRect(
                  borderRadius: BorderRadius.circular(isLarge ? 18 : 10),
                  child: CachedNetworkImage(
                    imageUrl: iconUrl,
                    fit: BoxFit.contain,
                    height: isLarge ? 120 : 60,
                    width: isLarge ? 120 : 60,
                    placeholder:
                        (context, url) => _buildShimmerBox(
                          size: isLarge ? 120 : 60,
                          radius: isLarge ? 18 : 10,
                        ),
                    errorWidget:
                        (context, url, error) =>
                            const Icon(Icons.error, size: 40),
                  ),
                ),
                const SizedBox(height: 8),
                // Name
                Text(
                  name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.brown.shade800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerBox({required double size, required double radius}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
