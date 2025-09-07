import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../blocs/search/search_bloc.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/search_categories_grid.dart';
import '../widgets/recent_searches_list.dart';
import '../widgets/search_results_view.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(AppSizes.horizontalPadding),
              child: SearchBarWidget(
                onChanged: (query) {
                  context.read<SearchBloc>().add(SearchQueryChangedEvent(query));
                },
                onSubmitted: (query) {
                  context.read<SearchBloc>().add(SearchPerformedEvent(query));
                },
              ),
            ),
            
            // Search Content
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitialState) {
                    return const _InitialView();
                  } else if (state is SearchLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.spotifyGreen,
                      ),
                    );
                  } else if (state is SearchResultsState) {
                    return SearchResultsView(
                      query: state.query,
                      tracks: state.tracks,
                      artists: state.artists,
                      albums: state.albums,
                      playlists: state.playlists,
                    );
                  } else if (state is SearchErrorState) {
                    return Center(
                      child: Text(
                        state.message,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.secondaryText,
                        ),
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

class _InitialView extends StatelessWidget {
  const _InitialView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSizes.spaceMD),
          
          // Recent Searches
          Text(
            AppStrings.recentSearches,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSizes.spaceMD),
          const RecentSearchesList(),
          
          const SizedBox(height: AppSizes.spaceLG),
          
          // Browse All
          Text(
            AppStrings.browseAll,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSizes.spaceMD),
          const SearchCategoriesGrid(),
        ],
      ),
    );
  }
}

