#!/bin/bash

# Create basic placeholder widgets
widgets=(
  "horizontal_playlist_list"
  "recently_played_list"
  "loading_shimmer"
  "search_bar_widget"
  "search_categories_grid"
  "recent_searches_list"
  "search_results_view"
  "library_header"
  "library_filter_chips"
  "library_content_list"
  "profile_header"
  "profile_stats"
  "profile_menu_list"
  "player_artwork"
  "player_controls"
  "player_progress_bar"
  "player_queue_button"
)

for widget in "${widgets[@]}"; do
  # Convert snake_case to PascalCase
  class_name=$(echo "$widget" | sed 's/_\([a-z]\)/\U\1/g' | sed 's/^./\U&/')
  
  cat > "lib/presentation/widgets/${widget}.dart" << WIDGET_EOF
import 'package:flutter/material.dart';

class ${class_name} extends StatelessWidget {
  const ${class_name}({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // Placeholder
  }
}
WIDGET_EOF
done

echo "Created placeholder widgets"
