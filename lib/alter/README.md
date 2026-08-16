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

| Component | Version | Description | Figma Node |
| :--- | :--- | :--- | :--- |
| **`ApplicationHeader`** | `v1.0.0` | Top header container with title, subtitle, composite action buttons, and a child `Widget? slot`. | Node `119:5716` |
| **`BottomNavigationBar`** | `v1.0.0` | Standard bottom navigation bar composed of `.BottomNavigationItem` instances (`itemCount`: three, four, five). | Node `117:4152` |
| **`BottomNavigationBarAction`** | `v1.0.0` | Action bottom bar composed of `.BottomNavigationButton` instances (`defaultAction`, `save`). | Node `60:2061` |
| **`ButtonText`** | `v1.0.1` | Text button with `ButtonType` (`gray`, `white`, `primary`) and `ButtonSize` (`normal`, `large`) variants. `minWidth: 64px`. | Node `130:8382` |
| **`ButtonIcon`** | `v1.0.0` | Square icon button (`48x48`) supporting `ButtonIconType` (`gray`, `white`, `primary`) variants. | Node `130:8371` |
| **`ButtonGraphicImage`** | `v1.0.1` | Compact `48x48` icon button container. | Node `28:875` |
| **`ButtonGraphicText`** | `v1.0.1` | Dual-label badge button (customizable `title` & `subtitle`). | Node `28:876` |

### Internal / Private Components (`lib/alter/components/bottom_navigation/`)
- **`.BottomNavigationItem` (`v1.0.0`, Node `1:392`)**: Used exclusively inside `BottomNavigationBar`.
- **`.BottomNavigationButton` (`v1.0.0`, Node `60:1950`)**: Used exclusively inside `BottomNavigationBarAction`.

---

## 🏷️ Version Tracking Rule

All Alter components export a hidden version reference constant:

```dart
static const String version = '1.0.0';
```
