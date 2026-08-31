import 'package:flutter/material.dart';
import '../alter/alter.dart';
import '../data/models/food_source_item.dart';
import '../data/services/nutrition_tracking_service.dart';
import 'horizon_list_item.dart';
import 'horizon_title_bar.dart';

/// Reusable Add Food Source modal component for Horizon.
///
/// Features:
/// - Vertical layout, 24px padding, 16px gap, rounded corners 24px, base-white background.
/// - Covers the Routine Page area precisely with transparent barrier (no dulled background).
/// - Child 1: `HorizonTitleBar` ('Add new source' / 'Quantities are editable post selection of source').
/// - Child 2: `FoodSourcesListContainer` (gap=16, no padding) with `HorizonListItem`'s ADD variant.
///   - Alphabetically sorted food sources.
///   - Reactively filterable by Application Header's `NutrientMap` (`selectedNutrientKey`).
///   - Retains foods in the list during session even when added (`isTracked` becomes true).
///   - `add_circle` button switches to `checkbox` filled on add.
///   - Clicking `checkbox` filled switches it back to `add_circle` and sets `isTracked = false`.
///   - `ToggleIcon` marks `isFavorite`.
///   - Food label reads: `${food.title}, ${food.defaultPortionGrams.round()}g`.
///   - Subtitle: Top 3 nutrient coverage percentages.
/// - Dynamic Search insertion: `Search` placed between food list and action bar when search ButtonIcon is active.
/// - Child 3: `AddActionBarContainer` (Horizontal layout, 16px gap, no padding, W=Fill, H=HUG):
///   - `ButtonText` Primary Large 'Done' (w=fill, height 64px).
///   - `ButtonIcon` Gray 64x64 with `favorite_border` (toggles `isFavorite` filter, selected state `stroke1000`).
///   - `ButtonIcon` Gray 64x64 with `search` (toggles Search bar, selected state `stroke1000`).
class HorizonAddSource extends StatefulWidget {
  /// Component version for reference.
  /// v1.3.0: Added onSearchToggle callback to coordinate hiding ApplicationHeader NutrientMap during active search with keyboard.
  static const String version = '1.3.0';

  final String? selectedNutrientKey;
  final VoidCallback? onDone;
  final ValueChanged<bool>? onSearchToggle;

  const HorizonAddSource({
    super.key,
    this.selectedNutrientKey,
    this.onDone,
    this.onSearchToggle,
  });

  /// Opens HorizonAddSource as a bottom-up modal covering the Routine page area.
  static Future<void> show(
    BuildContext context, {
    String? selectedNutrientKey,
    VoidCallback? onDone,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent, // Background is not dulled
      builder: (context) => HorizonAddSource(
        selectedNutrientKey: selectedNutrientKey,
        onDone: onDone,
      ),
    );
  }

  @override
  State<HorizonAddSource> createState() => _HorizonAddSourceState();
}

class _HorizonAddSourceState extends State<HorizonAddSource> {
  final NutritionTrackingService _trackingService = NutritionTrackingService();
  final TextEditingController _searchController = TextEditingController();

  AddSourceState? _state;
  bool _isLoading = true;

  // Locally retained food items loaded at open time, sorted alphabetically
  List<FoodSourceItem> _foodList = [];
  final Set<String> _addedFoodIds = {};

  bool _isFavoriteFilterActive = false;
  bool _isSearchActive = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    if (_isSearchActive) {
      widget.onSearchToggle?.call(false);
    }
    super.dispose();
  }

  Future<void> _loadData() async {
    final state = await _trackingService.loadAddSourceState();
    if (!mounted) return;

    final sortedList = List<FoodSourceItem>.from(state.foods);
    sortedList.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));

    setState(() {
      _state = state;
      _foodList = sortedList;
      _isLoading = false;
    });
  }

  List<FoodSourceItem> _getFilteredFoods() {
    return _foodList.where((food) {
      // Nutrient filter from Header NutrientMap
      if (!food.providesNutrient(widget.selectedNutrientKey)) {
        return false;
      }
      // Favorite filter
      if (_isFavoriteFilterActive && !food.isFavorite) {
        return false;
      }
      // Search query filter
      if (_isSearchActive && _searchQuery.trim().isNotEmpty) {
        final query = _searchQuery.trim().toLowerCase();
        final title = food.title.toLowerCase();
        if (!title.contains(query)) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  Future<void> _handleAddFood(FoodSourceItem food) async {
    await _trackingService.handleRoutineFoodAdded(food.foodId);
    food.isTracked = true;
    if (!mounted) return;
    setState(() {
      _addedFoodIds.add(food.foodId);
    });
  }

  Future<void> _handleRemoveFood(FoodSourceItem food) async {
    await _trackingService.handleRoutineFoodRemoved(food.foodId);
    food.isTracked = false;
    if (!mounted) return;
    setState(() {
      _addedFoodIds.remove(food.foodId);
    });
  }

  Future<void> _handleToggleFavorite(FoodSourceItem food) async {
    await _trackingService.toggleFoodFavorite(food.foodId);
    if (!mounted) return;
    setState(() {
      food.isFavorite = !food.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AlterSemanticTokens.baseWhite,
        borderRadius: BorderRadius.circular(24),
      ),
      child: _isLoading || _state == null
          ? const Center(
              child: CircularProgressIndicator(
                color: AlterSemanticTokens.textPrimary,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Child 1: HorizonTitleBar
                const HorizonTitleBar(
                  title: 'Add new source',
                  subtitle: 'Quantities are editable post selection of source',
                ),
                const SizedBox(height: 16),

                // Child 2: FoodSourcesListContainer (gap=16, no padding, vertical layout)
                Expanded(
                  child: _buildFoodSourcesListContainer(),
                ),
                const SizedBox(height: 16),

                // Dynamic Search Insertion (between List and Action Bar)
                if (_isSearchActive) ...[
                  Search(
                    controller: _searchController,
                    hintText: 'Search food sources...',
                    autofocus: true,
                  ),
                  const SizedBox(height: 16),
                ],

                // Child 3: AddActionBarContainer (Horizontal Layout, gap=16, no padding, W=Fill, H=HUG)
                _buildAddActionBarContainer(),
              ],
            ),
    );
  }

  Widget _buildFoodSourcesListContainer() {
    final filteredFoods = _getFilteredFoods();

    if (filteredFoods.isEmpty) {
      final nutrientName = widget.selectedNutrientKey != null &&
              _state?.nutrientMap.containsKey(widget.selectedNutrientKey) == true
          ? _state!.nutrientMap[widget.selectedNutrientKey]!.displayName
          : null;

      return Center(
        child: Text(
          nutrientName != null
              ? 'No food sources providing $nutrientName'
              : _isSearchActive && _searchQuery.isNotEmpty
                  ? 'No matching food sources found'
                  : _isFavoriteFilterActive
                      ? 'No favorite food sources'
                      : 'No available food sources',
          textAlign: TextAlign.center,
          style: AlterTypography.caption.copyWith(
            color: AlterSemanticTokens.textSecondary,
          ),
        ),
      );
    }

    final targetMap = _state!.targetMap;
    final nutrientMap = _state!.nutrientMap;

    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: filteredFoods.length,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final food = filteredFoods[index];
        final isAdded = _addedFoodIds.contains(food.foodId) || food.isTracked;
        final portionGrams = food.defaultPortionGrams;
        final title = '${food.title}, ${portionGrams.round()}g';
        final subtitle = food.buildNutrientCoverageSubtitle(
          portionGrams: portionGrams,
          targetMap: targetMap,
          nutrientMap: nutrientMap,
        );

        return HorizonListItem(
          host: HorizonListItemHost.add,
          title: title,
          subtitle: subtitle,
          isChecked: isAdded,
          isFavorite: food.isFavorite,
          onFavoriteChanged: (_) => _handleToggleFavorite(food),
          onCheckboxChanged: (_) => _handleRemoveFood(food),
          onRightActionTap: isAdded
              ? () => _handleRemoveFood(food)
              : () => _handleAddFood(food),
        );
      },
    );
  }

  Widget _buildAddActionBarContainer() {
    return Row(
      children: [
        // ButtonText Primary Large Done (w=fill, height 64px)
        Expanded(
          child: ButtonText(
            label: 'Done',
            type: ButtonType.primary,
            size: ButtonSize.large,
            onTap: () {
              widget.onDone?.call();
            },
          ),
        ),
        const SizedBox(width: 16),

        // ButtonIcon Gray 64x64 Favorite (filter isFavorite, selected state)
        ButtonIcon(
          type: ButtonIconType.gray,
          icon: Icons.favorite_border,
          size: 64.0,
          isSelected: _isFavoriteFilterActive,
          onTap: () {
            setState(() {
              _isFavoriteFilterActive = !_isFavoriteFilterActive;
            });
          },
        ),
        const SizedBox(width: 16),

        // ButtonIcon Gray 64x64 Search (toggles search bar, selected state)
        ButtonIcon(
          type: ButtonIconType.gray,
          icon: Icons.search,
          size: 64.0,
          isSelected: _isSearchActive,
          onTap: () {
            setState(() {
              _isSearchActive = !_isSearchActive;
              if (!_isSearchActive) {
                _searchController.clear();
                _searchQuery = '';
              }
            });
            widget.onSearchToggle?.call(_isSearchActive);
          },
        ),
      ],
    );
  }
}
