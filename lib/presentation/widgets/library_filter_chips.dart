import 'package:flutter/material.dart';
import '../blocs/library/library_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class LibraryFilterChips extends StatelessWidget {
  final LibraryFilter selectedFilter;
  final Function(LibraryFilter) onFilterChanged;

  const LibraryFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      LibraryFilter.all,
      LibraryFilter.playlists,
      LibraryFilter.artists,
      LibraryFilter.albums,
    ];

    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = filter == selectedFilter;
                
                return Padding(
                  padding: const EdgeInsets.only(right: AppSizes.spaceSM),
                  child: FilterChip(
                    label: Text(
                      _getFilterLabel(filter),
                      style: TextStyle(
                        color: isSelected ? Colors.black : AppColors.primaryText,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (_) => onFilterChanged(filter),
                    backgroundColor: Colors.transparent,
                    selectedColor: AppColors.spotifyGreen,
                    side: BorderSide(
                      color: isSelected ? AppColors.spotifyGreen : AppColors.secondaryText,
                    ),
                    showCheckmark: false,
                  ),
                );
              },
            ),
          ),
          // Sort and View Options
          IconButton(
            icon: const Icon(Icons.swap_vert),
            color: AppColors.primaryText,
            onPressed: () {
              // Show sort options
            },
          ),
          IconButton(
            icon: const Icon(Icons.grid_view),
            color: AppColors.primaryText,
            onPressed: () {
              // Toggle view type
            },
          ),
        ],
      ),
    );
  }

  String _getFilterLabel(LibraryFilter filter) {
    switch (filter) {
      case LibraryFilter.all:
        return 'All';
      case LibraryFilter.playlists:
        return 'Playlists';
      case LibraryFilter.artists:
        return 'Artists';
      case LibraryFilter.albums:
        return 'Albums';
      case LibraryFilter.downloaded:
        return 'Downloaded';
    }
  }
}