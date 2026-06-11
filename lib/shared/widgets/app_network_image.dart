import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/shared/widgets/app_shimmer.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.radius = 0,
    super.key,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, _) => AppShimmer(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        radius: radius,
      ),
      errorWidget: (context, _, _) => Container(
        width: width,
        height: height,
        color: AppColors.grey.withValues(alpha: 0.2),
        child: const Icon(Icons.broken_image, color: AppColors.grey),
      ),
    );

    if (radius > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: image,
      );
    }

    return image;
  }
}
