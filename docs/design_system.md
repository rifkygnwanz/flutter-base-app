# Design System & Styling Guide

Our design system is inspired by the **Apple Human Interface Guidelines (HIG)**. It is structured to deliver a premium, minimal, clean, and modern iOS-like interface.

---

## 1. Color System (`AppColors`)

All widgets MUST use semantic colors resolved from `AppColors.of(context)` to support dynamic Light and Dark mode switching automatically. Never use raw colors like `Colors.blue`.

| Role | Light Mode Value | Dark Mode Value | Purpose |
| :--- | :--- | :--- | :--- |
| **Primary** | `0xFF007AFF` (Blue) | `0xFF0A84FF` (Blue) | Primary interactive actions, toggles |
| **Secondary** | `0xFF5856D6` (Purple) | `0xFF5E5CE6` (Purple) | Accent actions, tag chips |
| **Background** | `0xFFF2F2F7` (Grouped) | `0xFF000000` (True Black) | Base canvas scaffolding color |
| **Surface** | `0xFFFFFFFF` (White) | `0xFF1C1C1E` (Dark Grey) | Cards, input fields, sheet panels |
| **Translucent Surface** | `0xCCFFFFFF` (80% Opacity) | `0xCC1C1C1E` (80% Opacity) | Frost overlay backing for blur filters |
| **Text Primary** | `0xFF000000` | `0xFFFFFFFF` | Main headings, body text, labels |
| **Text Secondary** | `0x993C3C43` (60%) | `0x99EBEBF5` (60%) | Supporting text, captions, labels |
| **Text Tertiary** | `0x4D3C3C43` (30%) | `0x4DEBEBF5` (30%) | Hint text, disabled text |
| **Border** | `0xFFC6C6C8` | `0xFF38383A` | Thin separator lines, input borders |
| **Error** | `0xFFFF3B30` | `0xFFFF453A` | Danger state, invalid inputs |
| **Success** | `0xFF34C759` | `0xFF30D158` | Positive state, completes |
| **Warning** | `0xFFFF9500` | `0xFFFF9F0A` | Alerts, non-blocking errors |

---

## 2. Typography (`AppTypography`)

Our typography matches Cupertino typographic scale ratios. Custom fonts can be integrated, but it falls back to native system fonts (`.SF Pro Text` / `Roboto`) by default.

- **Large Title**: `fontSize: 34`, Bold, letterSpacing `0.37`, height `1.2`. Used for main overview screens.
- **Title 1**: `fontSize: 28`, Bold, letterSpacing `0.36`, height `1.25`.
- **Title 2**: `fontSize: 22`, Bold, letterSpacing `0.35`, height `1.3`.
- **Headline**: `fontSize: 17`, SemiBold, letterSpacing `-0.41`, height `1.3`. Used for navigation title & primary actions.
- **Body**: `fontSize: 17`, Regular, letterSpacing `-0.41`, height `1.35`. Standard readable text.
- **Callout**: `fontSize: 16`, Regular, letterSpacing `-0.32`, height `1.35`. Special callout rows.
- **Subheadline**: `fontSize: 15`, Regular, letterSpacing `-0.24`, height `1.35`. Supporting meta descriptions.
- **Footnote**: `fontSize: 13`, Regular, letterSpacing `-0.08`, height `1.4`. List subtitle labels.
- **Caption**: `fontSize: 12`, Regular, letterSpacing `0.0`, height `1.4`. Input helpers, metadata.

---

## 3. Iconography (`AppIcon`)

**Direct use of Material Icons is prohibited.** All icons MUST be wrapped inside the `AppIcon` component and resolve from Apple's `CupertinoIcons` or `LucideIcons`:

```dart
// Correct:
AppIcon(CupertinoIcons.house_fill)

// Incorrect:
Icon(Icons.home)
```

---

## 4. Interaction & Feedback

To keep touch interaction satisfying and Apple-like:
1. **Pressed Visual State**: Buttons and tappable cards use a snappy spring scale down (to `0.96` on buttons, `0.98` on cards) and opacity shift. Ink ripples are completely disabled.
2. **Haptic Feedback**: High-priority interactive actions trigger `HapticFeedback.lightImpact()` to provide a tactile sensation on mobile devices.
3. **Translucency (Vibrancy)**: Headers and bottom tab bars utilize `BackdropFilter` to apply a frosted glass blur overlaying scrolled screen contents.

---

## 5. Continuous Design System Expansion

Our design system is a **living product** designed to grow systematically as the application expands. When new features require new visual patterns or widgets, developers must follow this strict expansion workflow:

### Step 1: Identify Component Scope
Before writing any UI code, evaluate if the component is feature-specific or global:
- **Local Widget**: If a widget is only used on a single screen or single feature module, implement it inside that feature's `presentation/widgets/` folder.
- **Global Candidate**: If the widget is needed by multiple features (e.g. a custom badge, filter chip, or status indicator), it should be built directly in `lib/shared/widgets/`.

### Step 2: Implement Using Tokens
When building the widget, strictly utilize established design system tokens:
- Use `AppColors.of(context)` for all colors.
- Use `AppSpacing` for all margins, padding, and gaps.
- Use `AppTypography.of(context)` or `AppText` for text elements.
- Use `AppRadius` and `AppShadows` for corners and elevations.
- **Prohibition**: Never hardcode colors, custom radii, or use raw Material design widgets/ripples directly.

### Step 3: Add to Reusable Library
1. Create a dedicated folder for your component category under `lib/shared/widgets/` (e.g., `lib/shared/widgets/badges/app_badge.dart`).
2. Export the new widget from your entry point or import it directly.
3. Run `fvm flutter analyze` to ensure clean static analysis.

### Step 4: Keep Documentation Synchronized
Whenever a new global widget or token is added, you MUST immediately update the following documents:
1. **`docs/widget_catalog.md`**: Add the new widget name, folder path, purpose, and key parameters.
2. **`docs/widget_usage.md`**: Add copy-pasteable example usage snippets showing default, loading, or custom configurations.

By keeping this process disciplined, we prevent code duplication, maintain visual integrity, and keep the application codebase scalable for future developers.
