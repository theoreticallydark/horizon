# Alter Design System

Alter is a lightweight, mobile-first design system built for Flutter applications.

---

## 🚀 Quick Start

### 1. Import Alter Components & Styles
Include the Alter barrel export in your screen or component file:

```dart
import 'package:horizon/alter/alter.dart';
```

---

## 🎨 Styles & Tokens Architecture

Alter organizes styles under `lib/alter/styles/`:

* **`swatches.dart` (`AlterColors`)**: Raw color palette swatches extracted from Figma variables (234 swatches).
* **`tokens.dart` (`AlterSemanticTokens`)**: Semantic color tokens mapped directly to `AlterColors` (e.g. `textPrimary`, `baseGray`, `stroke100`).
* **`typography.dart` (`AlterTypography`)**: Typography text style tokens (`displayXl`, `h1Bold`, `h1Serif`, `bodyLgBold`, `body`, `caption`, etc.).

---

## 🔤 Font Configuration

Alter components use bundled local font assets registered in `pubspec.yaml`:

- **`Geist`**: Primary sans-serif font family (Thin 100 to Black 900).
- **`InstrumentSerif`**: Serif accent font family (Regular & Italic).

### App-Level Theme Setup
Set `fontFamily: 'Geist'` in your main application theme:

```dart
MaterialApp(
  theme: ThemeData(
    fontFamily: 'Geist',
  ),
  home: const HomeScreen(),
);
```

---

## 🧩 Available Components

### Navigation Components (`lib/alter/components/`)
| Component | Version | Description | Figma Node |
| :--- | :--- | :--- | :--- |
| **`ApplicationHeader`** | `v1.0.0` | Top header container with title, subtitle, composite action buttons, and a child `Widget? slot`. | Node `119:5716` |
| **`BottomNavigationBar`** | `v1.0.1` | Standard bottom navigation bar composed of `.BottomNavigationItem` instances (`itemCount`: three, four, five). | Node `117:4152` |
| **`BottomNavigationBarAction`** | `v1.0.2` | Action bottom bar composed of `BottomNavigationBar` + `BottomNavigationButton` (`Type=Default`) or 3 `BottomNavigationButton` items (`Type=Save`). | Node `60:2061` |

### Button Components (`lib/alter/components/buttons/`)
| Component | Version | Description | Figma Node |
| :--- | :--- | :--- | :--- |
| **`ButtonText`** | `v1.0.1` | Text button with `ButtonType` (`gray`, `white`, `primary`) and `ButtonSize` (`normal`, `large`) variants. `minWidth: 64px`. | Node `130:8382` |
| **`ButtonIcon`** | `v1.2.0` | Square icon button (`48x48`, `64x64`) supporting `ButtonIconType` (`gray`, `white`, `primary`) and `isSelected` state variants. | Node `130:8371` |
| **`ButtonGraphicImage`** | `v1.0.1` | Compact `48x48` icon button container. | Node `28:875` |
| **`ButtonGraphicText`** | `v1.0.1` | Dual-label badge button (customizable `title` & `subtitle`). | Node `28:876` |

### Input Components (`lib/alter/components/search/`)
| Component | Version | Description | Figma Node |
| :--- | :--- | :--- | :--- |
| **`Search`** | `v1.0.1` | Reusable search input field with 20px rounded corners, 64px height, supporting Default, Typing, and Typed states. | Node `130:11237` |

### Private Components
- **`.BottomNavigationItem` (`v1.0.1`, Node `1:392`)**: `lib/alter/components/bottom_navigation/bottom_navigation_item.dart`
- **`.BottomNavigationButton` (`v1.0.1`, Node `60:1950`)**: `lib/alter/components/bottom_navigation/bottom_navigation_button.dart`

---

## 🏷️ Version Tracking Rule

All Alter components export a hidden version reference constant:

```dart
static const String version = '1.0.0';
```
