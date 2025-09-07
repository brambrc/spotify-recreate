import 'package:flutter/material.dart';
import '../../domain/models/user.dart';

class ProfileStats extends StatelessWidget {
  final User user;

  const ProfileStats({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // Placeholder
  }
}