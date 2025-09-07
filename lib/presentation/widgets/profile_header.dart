import 'package:flutter/material.dart';
import '../../domain/models/user.dart';

class ProfileHeader extends StatelessWidget {
  final User user;

  const ProfileHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // Placeholder
  }
}