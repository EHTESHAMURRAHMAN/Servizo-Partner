import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:servizo_vendor/app/Api/base_api.dart';

class LogoBuilder extends StatelessWidget {
  final String logoUrl;
  final double width;
  final double height;
  const LogoBuilder({
    super.key,
    required this.logoUrl,
    this.width = 43,
    this.height = 43,
  });

  @override
  Widget build(BuildContext context) {
    String lUlr = logoUrl;
    print('$base/ServiceProduct/$lUlr');
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      child: CachedNetworkImage(
        imageUrl: '$base/ServiceProduct/$lUlr',
        width: 40,
        height: 40,
        errorWidget: (context, error, stackTrace) => const Icon(Icons.error),
      ),
    );
  }
}
