import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: const Center(
        child: Text(
          AppStrings.signup,
          style: TextStyle(color: AppColors.primaryText),
        ),
      ),
    );
  }
}

