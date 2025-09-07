import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class LoadingShimmer extends StatelessWidget {
  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  const LoadingShimmer({
    super.key,
    this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.cardBackground,
      highlightColor: AppColors.spotifyLightGrey.withOpacity(0.3),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: borderRadius ?? BorderRadius.circular(AppSizes.radiusSM),
        ),
      ),
    );
  }

  // Factory constructors for common loading states
  factory LoadingShimmer.playlist() {
    return const LoadingShimmer(
      width: 160,
      height: 200,
    );
  }

  factory LoadingShimmer.track() {
    return const LoadingShimmer(
      width: 140,
      height: 180,
    );
  }

  factory LoadingShimmer.quickAccess() {
    return const LoadingShimmer(
      height: 56,
    );
  }
}