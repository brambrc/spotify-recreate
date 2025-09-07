import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../blocs/library/library_bloc.dart';
import '../widgets/library_header.dart';
import '../widgets/library_filter_chips.dart';
import '../widgets/library_content_list.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Library Header
            const LibraryHeader(),
            
            // Filter Chips
            BlocBuilder<LibraryBloc, LibraryState>(
              builder: (context, state) {
                if (state is LibraryLoadedState) {
                  return LibraryFilterChips(
                    selectedFilter: state.selectedFilter,
                    onFilterChanged: (filter) {
                      context.read<LibraryBloc>().add(
                        LibraryFilterChangedEvent(filter),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            
            // Content List
            Expanded(
              child: BlocBuilder<LibraryBloc, LibraryState>(
                builder: (context, state) {
                  if (state is LibraryLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.spotifyGreen,
                      ),
                    );
                  } else if (state is LibraryLoadedState) {
                    return LibraryContentList(
                      items: state.filteredItems,
                      viewType: state.viewType,
                      sortType: state.sortType,
                    );
                  } else if (state is LibraryErrorState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: AppSizes.iconXXL,
                            color: AppColors.secondaryText,
                          ),
                          const SizedBox(height: AppSizes.spaceMD),
                          Text(
                            state.message,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.secondaryText,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppSizes.spaceLG),
                          ElevatedButton(
                            onPressed: () {
                              context.read<LibraryBloc>().add(
                                LibraryLoadDataEvent(),
                              );
                            },
                            child: const Text(AppStrings.retry),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

