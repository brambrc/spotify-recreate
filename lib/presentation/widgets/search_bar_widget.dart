import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onChanged;
  final Function(String) onSubmitted;

  const SearchBarWidget({
    super.key,
    required this.onChanged,
    required this.onSubmitted,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: AppStrings.searchHint,
        prefixIcon: const Icon(Icons.search, color: AppColors.secondaryText),
        suffixIcon: IconButton(
          icon: const Icon(Icons.search, color: AppColors.spotifyGreen),
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              print('Search button pressed: ${_controller.text}');
              widget.onSubmitted(_controller.text);
            }
          },
        ),
      ),
      onChanged: (value) {
        print('Search onChanged: $value');
        widget.onChanged(value);
        // Auto-search after typing 2+ characters
        if (value.length >= 2) {
          widget.onSubmitted(value);
        }
      },
      onSubmitted: (value) {
        print('Search onSubmitted: $value');
        widget.onSubmitted(value);
      },
      textInputAction: TextInputAction.search,
    );
  }
}