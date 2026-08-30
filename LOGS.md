# Session Activity Log

- **2026-08-15 06:07 PM** - Initialized Flutter boilerplate project and verified existing files in `lib/`.
- **2026-08-15 06:13 PM** - Updated `lib/main.dart` with a centered "Hello World!" starter layout.
- **2026-08-15 06:24 PM** - Configured Figma MCP server token in `C:\Users\khark\.gemini\config\mcp_config.json`.
- **2026-08-15 06:27 PM** - Fixed MCP package name to `figma-developer-mcp` and verified CLI integration.
- **2026-08-15 06:30 PM** - Built `ButtonGraphicImage` widget from Figma node `28:875` (v1.0.0).
- **2026-08-15 06:32 PM** - Built `ButtonGraphicText` widget from Figma node `28:876` (v1.0.0).
- **2026-08-15 06:36 PM** - Restructured `lib/alter/components/` and created `lib/alter/alter.dart` barrel export file.
- **2026-08-15 06:44 PM** - Confirmed Dart naming conventions (`snake_case` filenames, `PascalCase` widget classes).
- **2026-08-15 06:48 PM** - Built `ButtonText` component set (supporting `ButtonType` and `ButtonSize` variants) from Figma node `130:8382` (v1.0.0).
- **2026-08-15 06:50 PM** - Added Normal and Large size variant demos to `lib/main.dart`.
- **2026-08-15 06:53 PM** - Configured `minWidth: 64` constraint for `ButtonText`.
- **2026-08-15 06:55 PM** - Added `google_fonts` package for Geist typography support.
- **2026-08-15 06:56 PM** - Cleaned up `lib/main.dart` UI to white background with buttons only.
- **2026-08-15 06:57 PM** - Updated all `ButtonText` labels to 'Add'.
- **2026-08-16 11:01 AM** - Added version reference constant (`static const String version = '1.0.0';`) to all Alter components.
- **2026-08-16 11:04 AM** - Refactored components to Pattern B (standalone `Theme.of(context)` typography with Geist fallback).
- **2026-08-16 11:08 AM** - Created `lib/alter/README.md` documentation covering setup, Geist font options, and component usage.
- **2026-08-16 11:24 AM** - Removed `google_fonts` package dependency and registered local font assets (`Geist` and `InstrumentSerif`) in `pubspec.yaml`.
- **2026-08-17 12:09 AM** - Extracted 234 color swatches from `Value.tokens.json` into `AlterColors`.
- **2026-08-17 12:16 AM** - Extracted 25 semantic color tokens from `Tokens 17 Aug.json` into `AlterSemanticTokens`.
- **2026-08-17 12:17 AM** - Reorganized tokens into `lib/alter/styles/` (`swatches.dart`, `tokens.dart`, `typography.dart`).
- **2026-08-17 12:21 AM** - Extracted 19 typography style tokens from Tailwind CSS definitions into `AlterTypography` (`typography.dart`).
- **2026-08-17 12:25 AM** - Refactored `ButtonText` (v1.0.1) to use `AlterSemanticTokens` and `AlterTypography.bodyLgBold`.
- **2026-08-17 12:27 AM** - Refactored `ButtonGraphicImage` (v1.0.1) to use `AlterSemanticTokens`.
- **2026-08-17 12:28 AM** - Refactored `ButtonGraphicText` (v1.0.1) to use `AlterColors` and `AlterSemanticTokens`.
- **2026-08-17 12:35 AM** - Built `ButtonIcon` component (v1.0.0) from Figma node `130:8371`.
- **2026-08-17 12:38 AM** - Built `ApplicationHeader` composite component (v1.0.0) from Figma node `119:5716`.
- **2026-08-17 01:03 AM** - Refactored `.BottomNavigationItem` (v1.0.1) to match Figma node `1:392`.
- **2026-08-17 01:05 AM** - Refactored `BottomNavigationBar` (v1.0.1) to match Figma node `117:4152`.
- **2026-08-17 01:17 AM** - Refactored `.BottomNavigationButton` (v1.0.1) to match Figma node `60:1950`.
- **2026-08-17 12:10 PM** - Refactored `BottomNavigationBarAction` (v1.0.2) based on Figma node `60:2061`.
- **2026-08-17 12:45 PM** - Reorganized button components into `lib/alter/components/buttons/`.
- **2026-08-17 12:47 PM** - Moved pages from `lib/horizon/pages/` to `lib/pages/`.
- **2026-08-17 01:05 PM** - Enforced Design System separation rule across all Alter components.
- **2026-08-17 01:25 PM** - Configured single shared `ApplicationHeader` dynamically in `lib/main.dart`.
- **2026-08-17 01:37 PM** - Built `Pill` component (v1.0.0) in `lib/alter/components/pills/pill.dart` from Figma node `23:270`.
- **2026-08-17 01:41 PM** - Fixed stroke alignment behavior (strokeAlign: INSIDE) in `Pill`: compensated padding by `_borderWidth`.
- **2026-08-17 01:45 PM** - Refactored `Pill` (v1.0.1) to vertical layout (`Column`) with `2px` spacing between `label` and `value` for `defaultSize`, and updated gray fill to `AlterSemanticTokens.ui1` (`#F3F4F6`).
- **2026-08-17 01:49 PM** - Fixed completed unselected pill `_borderWidth` to return `0.0` (instead of `1.0`).
- **2026-08-17 03:45 PM** - Created `HorizonApplicationHeader` wrapper in `lib/horizon/horizon_application_header.dart`.
- **2026-08-17 03:47 PM** - Created `HorizonBottomNavigationBarAction` wrapper in `lib/horizon/horizon_bottom_navigation_bar_action.dart`.
- **2026-08-18 02:33 PM** - Created `NutrientPill` wrapper component in `lib/horizon/nutrient_pill.dart`.
- **2026-08-18 02:42 PM** - Created `NutrientMap` component in `lib/horizon/nutrient_map.dart` from Figma node `120:6965`.
- **2026-08-18 02:45 PM** - Updated `HorizonApplicationHeader` to inject `NutrientMap` into `ApplicationHeader.slot`.
- **2026-08-18 02:50 PM** - Configured `NutrientPill` with `horizontalPadding: 4.0`.
- **2026-08-18 02:52 PM** - Added `hasLabel` and `hasValue` to Alter's `Pill`, and set `NutrientPill` default `value: '85%'`.
- **2026-08-18 03:06 PM** - Upgraded `Pill` (v1.0.2) and `ApplicationHeader` with smooth implicit transitions (`AnimatedContainer`, `AnimatedSize`, `AnimatedOpacity`, curve `Curves.easeInOutCubic`, duration `250ms`).
- **2026-08-18 03:10 PM** - Updated `HorizonApplicationHeader`: set `hasProfileAction = false` and `hasStyleButton = true` on Track page (`Today`).
- **2026-08-18 03:12 PM** - Updated `HorizonApplicationHeader`: set `hasStyleButton = false` and `hasProfileAction = true` on Routine page (`Plan Routine`).
- **2026-08-25 07:45 PM** - Integrated Isar database with `UserProfile`, `NutrientInfo`, and `FoodSourceItem` collections and loaded `sources/dri_and_foods.json`.
- **2026-08-25 08:30 PM** - Built `demographic_lookup.dart` matching DRI values to user age, sex, and pregnancy/lactation state.
- **2026-08-25 09:15 PM** - Built `HorizonTitleBar` (v1.1.0) in `lib/horizon/horizon_title_bar.dart` from Figma node `130:4993`.
- **2026-08-25 10:00 PM** - Added `ButtonIconGhost` (v1.0.0), `Checkbox` (v1.0.0), and `ToggleIcon` (v1.0.0) select/action primitives to Alter.
- **2026-08-25 11:30 PM** - Built `ListItem` composite widget in `lib/alter/components/list_item.dart` (v1.0.0) from Figma node `130:4639`.
- **2026-08-26 01:00 AM** - Split tracking database into `TrackRecordDaily` and `TrackRecordWeekly` collections for daily and weekly food intake tracking.
- **2026-08-26 01:45 AM** - Implemented dynamic 10% trigger nutrient coverage rule (`determineFoodFrequency()`) checking `Vit C`, `Coll.`, `Fiber`, `Mg`, `Ca`, `K`, `Creat.`, `Protein`.
- **2026-08-26 02:30 AM** - Added `trackingFrequencyOverride` to `FoodSourceItem` allowing manual frequency overrides with automatic reset to `null` on untracking.
- **2026-08-26 03:45 AM** - Built `HorizonListItem` (v1.2.0) in `lib/horizon/horizon_list_item.dart` with 8 distinct host variants from Figma node `130:4671`.
- **2026-08-26 04:00 AM** - Added comprehensive interactive component preview in `lib/pages/stats_page.dart`.
- **2026-08-26 04:08 AM** - Upgraded `HorizonListItem` to v1.3.0 by consolidating `trackDailyChecked` dynamically into `trackDaily` via `isChecked`.
- **2026-08-26 04:10 AM** - Removed redundant horizontal padding on `ListItem` to ensure exact 24px container edge alignment matching Figma.
- **2026-08-26 04:28 AM** - Calibrated `UserProfile` with `weightKg: 70.0` and `heightCm: 175.0` for bodyweight-adjusted protein target calculation (`weightKg * 0.8 * strictness`).
- **2026-08-26 04:52 AM** - Built Track page daily food checklist with `<title>, <dailyTarget>` format and checkbox logging.
- **2026-08-26 04:55 AM** - Added Weekly goals section with gray/100 divider, `HorizonTitleBar`, and `trackWeekly` items (`<title>, <amountConsumed>` with `Target (<weeklyTarget>g)`).
- **2026-08-26 04:56 AM** - Upgraded `HorizonListItem` to v1.4.0 with dynamic toggle between `ButtonIconGhost(add_box)` (incrementing by `target / 7`) and `Checkbox(checked)`.
- **2026-08-26 04:58 AM** - Added 120px bottom spacer offset containers across `TrackPage`, `StatsPage`, and `RoutinePage` to prevent UI blockage by the bottom navigation bar.
- **2026-08-26 05:05 AM** - Upgraded `HorizonListItem` to v1.5.0: removed `trackWeeklyChecked` variant (dynamic toggle handled via `isChecked` on `trackWeekly`) and updated `StatsPage` preview.
- **2026-08-26 05:25 AM** - Implemented Routine page with `HorizonListItem` (`routine` and `routineRemove` variants): dynamic top 3 nutrient coverage subtitle format (`'Key' '%coverage' • ...`), single-tap & continuous tap-and-hold target increment/decrement with minimum boundary stop at 1g, red remove icon transition, and 120px bottom navigation offset.
- **2026-08-26 05:30 AM** - Structured Routine page into `Daily targets` and `Weekly targets` sections using `HorizonTitleBar` with a `Divider(color: gray/100)` between sections.
- **2026-08-26 05:35 AM** - Calibrated seed demo routine foods (adding Salmon, Spinach, Flaxseed, and Bone Broth) to achieve 100%+ coverage across all 20 standard nutrients on the `NutrientMap`.
- **2026-08-26 05:40 AM** - Enforced complete protein rule: `total_protein` yield, targets, daily/weekly frequency qualification, and routine subtitles only qualify foods with `proteinIndex == 1`.
- **2026-08-26 05:45 AM** - Made `HorizonApplicationHeader` subtitle reactive: dynamically computes total planned routine calories and complete protein (`proteinIndex == 1`) in real-time from active tracked routine foods (`<calories> calories • <protein>g protein`).
- **2026-08-26 05:50 AM** - Refreshed database initialization: ensures full nutrition payload, `energy`, and `proteinIndex` are updated in existing database records on startup so that planned calories, protein, and 100%+ nutrient coverage pills reflect accurately.
- **2026-08-26 06:10 AM** - Filtered `HorizonListItem` Routine subtitle: ensures top nutrient coverage badges strictly qualify active tracked nutrients (`nutrientInfo.isTracked == true`), and ensured `loggedFoods` list is growable during window sync.
- **2026-08-26 06:15 AM** - Implemented Multi-Select `NutrientMap` Filtering: tapping nutrient pills toggles their `isSelected` state, dynamically filtering `HorizonListItem`s on both Track and Routine pages to foods providing coverage to the selected nutrients, and automatically clears selections when switching between navigation tabs.
- **2026-08-26 06:20 AM** - Restored Pristine USDA Dataset: reverted all injected collagen, creatine, and boosted nutrient values in `sources/dri_and_foods.json` back to authentic USDA SR Legacy data while maintaining calculated `energy` and binary `protein_index`.
- **2026-08-26 06:30 AM** - Updated `IsarService.seedDemoRoutine()`: populated clean demo routine using 15 authentic USDA foods (Guava, Pumpkin Seeds, Sunflower Seeds, Flaxseed, Almonds, Eggs, Spinach, Lentils, Carrots, Yogurt, Cheddar Cheese, Broccoli, Potatoes, Banana, Iodized Salt) without injected Salmon or Bone Broth.
- **2026-08-26 06:35 AM** - Enabled `Om3` Baseline Target Mapping: `IsarService` now accurately loads `app_default_target` (250mg) from `sources/dri_and_foods.json` when standard RDA is null, allowing `omega_3_epa_dha` to compute live coverage and map to the `Om3` pill.
- **2026-08-26 06:40 AM** - Updated `NutrientMap` to Single-Select: simplified nutrient filtering to single-selection mode (`selectedNutrientKey`), where tapping an active nutrient highlights that pill and filters Track & Routine lists, and tapping again deselects it.
- **2026-08-26 06:45 AM** - Normalized `HorizonListItem` Subtitle Coverage: updated `_buildNutrientCoverageSubtitle()` in `RoutinePage` to compute coverage percentages relative to the nutrient's frequency (comparing weekly yield $\times 7$ against weekly target), ensuring subtitle percentages (e.g. Vit B12 82% on Eggs) match the `NutrientMap` pill totals.
- **2026-08-26 06:50 AM** - Updated `ApplicationHeader` (`v1.0.2`): dynamically hugs action elements with spacing only between adjacent active items, completely eliminating the trailing 8px space when single actions (like `ButtonGraphicText` on Track header) are rendered.
- **2026-08-26 06:55 AM** - Cleaned `StatsPage`: removed mock `HorizonListItem` variant previews and set a clean placeholder view.
- **2026-08-26 07:05 AM** - Implemented UI & Database Performance Optimizations:
  1. *Debounced Target Writes*: Long-pressing `-` / `+` on routine items now updates target locally with instant visual response and flushes a single write transaction to Isar on release, eliminating continuous disk I/O.
  2. *Consolidated Stream Architecture*: Created `watchRoutinePageState()` and `watchTrackPageState()` in `NutritionTrackingService` to combine multi-tier watcher streams into single unified stream builders.
  3. *In-Memory Pre-Computed Target Cache*: Routine item subtitles now perform $O(1)$ dictionary lookups against pre-calculated effective nutrient targets rather than re-computing demographic rules per item on every render frame.
- **2026-08-26 07:15 AM** - Smoothed `HorizonApplicationHeader` Tab Transitions: unified the header widget instance across all navigation tabs and wrapped it in `AnimatedSize(duration: 300ms, curve: Curves.easeInOutCubic)`, enabling seamless height and content transitions between Stats (no slot) and Track/Routine (with `NutrientMap` in slot).
- **2026-08-26 07:25 AM** - Fixed `TrackPage` Immediate Checkbox Reaction: updated `watchTrackPageState()` in `NutritionTrackingService` to listen directly to `trackRecordDailys` changes rather than routine food items, ensuring checkboxes and stepper values reflect immediately upon click without needing to navigate across tabs.
- **2026-08-26 07:35 AM** - Removed Redundant `NutrientPill`: deleted `lib/horizon/nutrient_pill.dart` and refactored `NutrientMap` to render the design system `Pill` directly, removing an unnecessary pass-through layer.
- **2026-08-26 07:45 AM** - Applied Additional Codebase Optimizations:
  1. *Unified `HorizonListItemHost.add` (`v1.7.0`)*: Consolidated `add` and `addIsFavorite` into a single `add` variant driven dynamically by `isFavorite: bool`.
  2. *In-Memory Planned Routine Coverage Stream*: Refactored `watchPlannedRoutineCoverage()` in `NutritionTrackingService` to compute live coverage percentages directly from the emitted `List<FoodSourceItem>` payload without issuing duplicate disk queries.
- **2026-08-26 07:50 AM** - Consolidated `NutrientMap` Stream Architecture: introduced `watchNutrientMapState(isTrackView)` and `NutrientMapState` in `NutritionTrackingService` to combine nutrient lists and calculated live coverage into a single reactive stream, eliminating nested `StreamBuilder`s and duplicate widget tree rebuilds.
- **2026-08-26 08:00 AM** - Implemented Live Consumed Calories & Protein in `HorizonApplicationHeader`: added `watchTodayTrackHeaderEnergyAndProtein()` in `NutritionTrackingService` to compute real-time consumed calories and complete protein alongside planned routine targets, replacing placeholder zeros with dynamic `$consumedCal/$plannedCal calories • $consumedProt/${plannedProt}g protein`.
- **2026-08-26 08:10 AM** - Enhanced `TrackPage` Event Stream & Tokens:
  1. *Merged Watcher Triggers*: Updated `watchTrackPageState()` in `NutritionTrackingService` to subscribe concurrently to both `trackRecordDailys` and `trackRecordWeeklys`, ensuring changes to either daily checkboxes or weekly steppers update the UI immediately in real time.
  2. *Design Token Alignment*: Updated `TrackPage` section divider from hardcoded `AlterColors.colorsGray100` to `AlterSemanticTokens.stroke200` with 24px vertical padding, aligning with `RoutinePage`.
- **2026-08-26 08:15 AM** - Standardized Section Dividers to `stroke100`: updated the `Divider` color token across both `TrackPage` and `RoutinePage` to `AlterSemanticTokens.stroke100` (`stroke/100`).
- **2026-08-26 08:25 AM** - Configured `Pill` Horizontal Padding: set `horizontalPadding: 2.4` on all `Pill` instances rendered within `NutrientMap`.
- **2026-08-26 08:30 AM** - Removed `Prot.` and `Cal` from `NutrientMap`: removed `energy` and `total_protein` from `primaryVisibleNutrients` in `IsarService.seedDriData()` so that `NutrientMap` exclusively displays the 20 micro-nutrients & essential lipids, while Calories and Protein remain tracked exclusively in the Application Header subtitle.
- **2026-08-26 08:40 AM** - Implemented Dynamic `HorizonTitleBar` on Nutrient Filter: when filtering via a `Pill` in `NutrientMap`, both `TrackPage` and `RoutinePage` display a top `HorizonTitleBar` with `title: Nutrient.displayName` and `subtitle: Tracked Daily 🔁 • yield/target(Unit)` or `Tracked Weekly 📆 • yield/target(Unit)`, displaying real-time consumed/planned intake against targets.
- **2026-08-26 08:45 AM** - Formatted Filter Metrics with Semantic Color Thresholds: updated `HorizonTitleBar` to `v1.2.0` (with `subtitleWidget` support), and formatted the `amount/target(Unit)` text using `AlterTypography.captionBold` styled with `textDanger` (<75%), `textCaution` (75%–99%), or `textSuccess` (>=100%).
- **2026-08-26 08:50 AM** - Retained Weekly Goals & Targets Section Headers: ensured the `HorizonTitleBar` for 'Weekly targets' (RoutinePage) and 'Weekly goals' (TrackPage) remains visible when weekly items are present, even during an active nutrient pill filter.
- **2026-08-26 08:55 AM** - Filter Header on Zero Matching Items & Unit Sanitization:
  1. Removed the center placeholder message on filter so that selecting a nutrient with 0 routine foods cleanly renders the top `HorizonTitleBar` with `0/target` metric without clutter.
  2. Sanitized unit labels (e.g. converting `µg RAE/day` to clean `µg`) across both `RoutinePage` and `TrackPage`.
- **2026-08-26 09:05 AM** - Semantic Human-Friendly Food Titles Transformation:
  1. Audited all 1,804 food items in `sources/dri_and_foods.json` and replaced robotic/truncated USDA titles (e.g. `Cheese reduced`, `Egg 71287`, `Flour wheat al 89951`, `Salmon pink`) with semantically accurate, consumer-grade food titles (e.g. `Reduced Fat Cheddar Cheese`, `Whole Egg (Raw)`, `All-Purpose Flour`, `Pink Salmon (Raw)`).
  2. Updated `IsarService.seedDriData()` to synchronize updated titles, energies, and protein indices directly to existing database records on startup.
- **2026-08-26 09:10 AM** - Constrained Food Titles to Maximum 24 Characters: audited and formatted all 1,804 food titles in `sources/dri_and_foods.json` to strictly fit within a 24-character limit for clean single-line UI rendering without clipping or awkward line wraps.
- **2026-08-26 09:15 AM** - Cascaded Food Titles to Active Track Records: updated `IsarService.seedDriData()` and `NutritionTrackingService._syncDateRecordDaily()` / `_syncWeekRecordWeekly()` so that previously created daily and weekly tracking log records (`TrackRecordDaily` and `TrackRecordWeekly`) automatically have their embedded `TrackedFoodEntry.foodTitle` updated to the new titles without requiring a database wipe.
- **2026-08-26 09:20 AM** - Updated Vitamin B12 Short Key: changed `vitamin_b12`'s short display key from `Vit B12` to `V B12` across all 22 DRI demographic definitions in `sources/dri_and_foods.json` and synced to `NutrientInfo.shortKey` in Isar.
- **2026-08-26 09:25 AM** - Fixed Weekly Nutrient Coverage Reactivity in `NutrientMap`:
  1. Multiplexed stream subscriptions in `watchNutrientMapState(isTrackView = true)` to listen to both `trackRecordDailys` and `trackRecordWeeklys` changes so that weekly steppers trigger immediate pill redraws.
  2. Fixed weekly nutrient percentage calculation in `watchNutrientMapState` by directly combining daily and weekly coverage summaries instead of incorrectly dividing weekly targets by 7.
- **2026-08-26 09:30 AM** - Unified Live Track Nutrient Coverage Calculation: refactored `watchNutrientMapState(isTrackView = true)` to compute actual consumed amounts directly in-memory from logged foods in both daily and weekly records, properly scaling weekly nutrients (such as Folate, Vitamin A, Vitamin D) from daily consumed intakes $(dailyConsumed \times 7)$ plus weekly intakes to accurately trigger the completed state $(\ge 100\%)$.
- **2026-08-26 09:35 AM** - Bidirectional Cross-Frequency Food Intake Synchronization:
  1. Updated `toggleDailyFoodChecked()` and `updateWeeklyFoodIntake()` in `NutritionTrackingService` to synchronize consumed grams bidirectionally across both `TrackRecordDaily` and `TrackRecordWeekly`.
  2. Stepping a weekly food (e.g. $+60\text{g}$ Banana) immediately logs the exact $+60\text{g}$ intake into today's `TrackRecordDaily` and contributes its energy, protein, and micronutrients to today's header and pill map, while also rolling into the week's cumulative total.
  3. Checking a daily food immediately increments the weekly tracking record by its daily planned portion.
- **2026-08-26 09:40 AM** - Fixed `FixedLengthListMixin` Exception in Tracking Service: converted `dailyRecord.loggedFoods` and `weeklyRecord.loggedFoods` into growable `List<TrackedFoodEntry>.from(...)` lists before performing mutations or additions, preventing runtime crashes when unchecking or stepping weekly items.
- **2026-08-26 09:55 AM** - Built Horizon Debugger & Time Machine:
  1. Created `HorizonDebugModal` (`lib/horizon/debug_modal.dart`) allowing real-time audit of Target vs Coverage (and raw amounts) for all 20 nutrients plus Calories and Protein across both Track View (Actual Consumed) and Routine View (Planned Routine).
  2. Added expandable contributing food breakdowns under each nutrient row, showing each source food item's consumed or planned grams and exact quantitative yield.
  3. Built interactive Time Simulator toolbar: supports stepping dates backward/forward ($\pm 1$ day) or resetting to real device time with live auto-refresh across all app streams, headers, and checklists.
- **2026-08-26 10:20 AM** - Robust Handling of Routine Food Removal & History Retention:
  1. Updated `handleRoutineFoodRemoved()` in `NutritionTrackingService` so that when a food is removed from routine, unconsumed ($0\text{g}$) placeholder entries are cleaned up, but any previously consumed ($>0\text{g}$) records are preserved across past and current daily logs (`isFromRoutine = false`).
  2. Updated `TrackPage` (`lib/pages/track_page.dart`) section list filtering:
     - Daily section shows all active daily routine foods PLUS any food item with consumption on that day ($>0\text{g}$), even if removed from routine or originally a weekly food.
     - Weekly section shows only active weekly routine foods (`!isTracked` items drop out of future weekly goals).
  3. Extended `watchTrackPageState()` to load all referenced foods into `foodMap` so removed items retain their titles and nutritional values when rendered.
- **2026-08-26 10:45 AM** - Upgraded Debug Modal with Food Frequency Switcher & Refined UI:
  1. Added **Foods & Freq** tab to `HorizonDebugModal` (`lib/horizon/debug_modal.dart`), categorizing routine foods into Daily and Weekly sections with interactive segmented toggle switches.
  2. Tapping `Daily` or `Weekly` triggers `NutritionTrackingService.setFoodFrequencyOverride()`, dynamically reassigning the food's frequency and instantly re-syncing Track Page sections, checklists, and Routine Page coverage without requiring manual gram edits.
  3. Polished tab bar navigation, headers, and section indicators.
- **2026-08-28 10:45 AM** - Built `Search` component (v1.0.0) in `lib/alter/components/search/search.dart` matching Figma node `130:11237` (Component Set `Search` with `State=Default`, `State=Typing`, and `State=Typed` variants) using `AlterSemanticTokens` and `AlterTypography.geistFont`.
- **2026-08-28 10:52 AM** - Refactored `Search` component to `v1.0.1`: removed extra non-Figma leading/trailing slots to strictly adhere to Figma node `130:11237`.
- **2026-08-28 10:54 AM** - Removed component preview from `StatsPage` (`lib/pages/stats_page.dart`), restoring clean placeholder view.
- **2026-08-28 11:15 AM** - Upgraded `ButtonIcon` to `v1.1.0`: added `isSelected: bool` property where stroke becomes `AlterSemanticTokens.stroke1000` for `ButtonIconType.gray` and `ButtonIconType.white`.
- **2026-08-28 11:18 AM** - Removed component preview from `StatsPage` (`lib/pages/stats_page.dart`), restoring clean placeholder view.
- **2026-08-28 11:27 AM** - Built `HorizonAddSource` (v1.0.0) in `lib/horizon/horizon_add_source.dart` featuring 24px padding, 16px gap, `HorizonTitleBar`, untracked food sources list using `HorizonListItemHost.add` (with session retention, `CheckboxState.checked`, top 3 nutrient percentages, and `ToggleIcon` for `isFavorite`), dynamic `Search` bar integration, and `AddActionBarContainer` (Done button + Favorite filter + Search toggles with `ButtonIcon.isSelected`). Connected Routine page bottom navigation action button to open `HorizonAddSource` bottom-up modal.
- **2026-08-28 11:38 AM** - Upgraded `ButtonIcon` to `v1.2.0` (with 64x64 size support) and `HorizonAddSource` to `v1.1.0`: configured modal to precisely cover Routine Page area with undulled transparent background, 64x64 action buttons, bidirectional tracking check/uncheck toggle (`isTracked` toggling between `add_circle` and `checkbox-filled`), and alphabetical sorting across food sources.
- **2026-08-28 11:51 AM** - Upgraded `HorizonAddSource` to `v1.2.0`: integrated reactive `selectedNutrientKey` filtering driven by the Application Header's `NutrientMap` on the Routine page with zero disruption to existing pill tracking/filtering behavior.
- **2026-08-28 11:56 AM** - Added smooth bottom-up slide & fade animation (`AnimatedSlide`, `AnimatedOpacity`, `Curves.easeInOutCubic`, `300ms`) for `HorizonAddSource` within `RoutinePage`, cleanly clipped to the 24px container border.
- **2026-08-28 12:04 PM** - Added dynamic NutrientMap collapse in `HorizonApplicationHeader`: when Search is active in `HorizonAddSource` and the software keyboard is visible (`MediaQuery.viewInsets.bottom > 0`), `NutrientMap` smoothly collapses via `AnimatedSize` (250ms), maximizing vertical space for the search results list.
- **2026-08-30 11:00 AM** - Upgraded `Pill` to `v1.0.3` and smoothed `HorizonApplicationHeader` `NutrientMap` transitions between Track and Routine pages: unified header `NutrientMap` key (`header_nutrient_map`), assigned stable item keys (`pill_<key>`), converted `NutrientMap` to stateful caching to eliminate stream-switch redraw flickers, and synchronized `AnimatedCrossFade` label show/hide with `AnimatedContainer` size transitions (`250ms`, `easeInOutCubic`).

---

## 3. Truth Table Matrix: Track Page Single Unique Entity Display Rules

The table below defines how every food item is rendered on the **Track Page** across its lifecycle states (Routine status, Tracking frequency, and Consumption history), strictly guaranteeing that **each food is rendered at most once** (no duplicate rows between Daily Foods and Weekly Goals) while maintaining immutable historical records.

| Routine Status | Tracking Frequency | Consumed Today (`> 0g`) | Appears in Daily Foods? | Appears in Weekly Goals? | Total Times Rendered | Behavior / Notes |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Active Routine** (`isTracked: true`) | `daily` | `0g` (Unchecked) | **YES** (Checkbox: `0g`) | NO | **1** | Planned daily habit waiting for checkoff. |
| **Active Routine** (`isTracked: true`) | `daily` | `> 0g` (Checked) | **YES** (Checkbox: `Done`) | NO | **1** | Completed daily habit for today. |
| **Active Routine** (`isTracked: true`) | `weekly` | `0g` (Unstepped) | NO | **YES** (Stepper: `0g`) | **1** | Active weekly goal for current week. |
| **Active Routine** (`isTracked: true`) | `weekly` | `> 0g` (Stepped) | **NO** *(Duplicate Blocked)* | **YES** (Stepper: `+Xg`) | **1** | Consumed delta logs in background for daily macros, but remains strictly in Weekly Goals UI. |
| **Removed from Routine** (`isTracked: false`) | `daily` | `0g` (Unconsumed) | NO | NO | **0** | Placeholder cleaned up; no ghost items. |
| **Removed from Routine** (`isTracked: false`) | `daily` | `> 0g` (Historical Log) | **YES** (Logged: `Xg`) | NO | **1** | Preserved consumption history on that specific day (`isFromRoutine: false`). |
| **Removed from Routine** (`isTracked: false`) | `weekly` | `0g` (Unconsumed) | NO | NO | **0** | Drops out of Weekly Goals; no ghost items. |
| **Removed from Routine** (`isTracked: false`) | `weekly` | `> 0g` (Historical Log) | **YES** (Logged: `Xg`) | NO | **1** | Preserved consumption history in Daily section for that day; dropped from Weekly Goals. |

