import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import 'cached_image.dart';

class GreetingHeader extends StatelessWidget {
  final String userName;
  final String? userImage;

  const GreetingHeader({
    super.key,
    required this.userName,
    this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    String greeting;
    
    if (hour < 12) {
      greeting = AppStrings.goodMorning;
    } else if (hour < 17) {
      greeting = AppStrings.goodAfternoon;
    } else {
      greeting = AppStrings.goodEvening;
    }

    return Padding(
      padding: const EdgeInsets.all(AppSizes.horizontalPadding),
      child: Row(
        children: [
          Expanded(
            child: Text(
              greeting,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (userImage != null)
            ClipOval(
              child: CachedImage(
                imageUrl: userImage,
                width: AppSizes.iconXL,
                height: AppSizes.iconXL,
              ),
            ),
        ],
      ),
    );
  }
}

