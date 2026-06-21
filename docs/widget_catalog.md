# Reusable Widget Catalog

This catalog documents all global reusable UI components within the starter kit foundation.

---

## 1. AppScaffold (`lib/shared/widgets/scaffold/app_scaffold.dart`)
- **Purpose**: Base screen canvas wrapping. Ensures consistent background colors, manages Top/Bottom/Left/Right safe areas, and provides built-in fullscreen modal loading overlays.
- **Key Parameters**:
  - `body`: The core widget content.
  - `appBar`: PreferredSizeWidget header.
  - `isLoading`: Shows semi-transparent blocker and loading spinner.
  - `backgroundColor`: Custom override color.
  - `extendBodyBehindBottomBar`: If true, content flows behind the translucent bottom navigation bar.
  - `dismissKeyboardOnTap`: If true (default), tapping outside of text input fields automatically dismisses the keyboard.

---

## 2. AppNavigationBar (`lib/shared/widgets/app_bar/app_navigation_bar.dart`)
- **Purpose**: Custom navigation header inspired by iOS `UINavigationBar`. Implements a frosted-glass translucent background overlay.
- **Key Parameters**:
  - `title`: Header text, centered by default.
  - `showBackButton`: Automatically inserts iOS chevron navigation if router history is present.
  - `backButtonText`: Appends supporting string next to back chevron.
  - `transparent`: Sets background color to transparent with no divider line.
  - `actions`: Trailing action items list.

---

## 3. AppTabBar (`lib/shared/widgets/navigation/app_tab_bar.dart`)
- **Purpose**: Translucent, frosted-glass bottom navigation tab bar mimicking `CupertinoTabBar`.
- **Key Parameters**:
  - `currentIndex`: Selected tab index.
  - `onTap`: Callback when a tab is tapped.
  - `items`: List of `AppTabBarItem` objects.

---

## 4. AppIcon (`lib/shared/widgets/icons/app_icon.dart`)
- **Purpose**: Unified iconography widget wrapping `CupertinoIcons` or `LucideIcons`. Direct use of Material Icons is prohibited.
- **Key Parameters**:
  - `icon`: IconData.
  - `size`: Double size.
  - `color`: Custom icon color.

---

## 5. AppText (`lib/shared/widgets/text/app_text.dart`)
- **Purpose**: Centralized typography renderer. Directly maps text rendering to the `AppTypography` HIG scale.
- **Key Parameters**:
  - `text`: String label.
  - `variant`: Selection of HIG typography scale (e.g. `largeTitle`, `title1`, `title2`, `headline`, `body`, `callout`, `subheadline`, `footnote`, `caption`).
  - `color`: Custom text color override.
  - `maxLines`/`overflow`: Formatting rules.

---

## 6. AppButtons (`lib/shared/widgets/buttons/app_buttons.dart`)
Includes five distinct button styles, each wrapping a custom `_TouchBounceInteraction` for spring-scale tap responses (to `0.96`), Apple tactile haptic impact, and enforcing 44x44 minimum touch targets.

### AppPrimaryButton
- **Purpose**: Primary prominent visual action button. Default height is 52px.
- **Key Parameters**: `text`, `onPressed`, `loading` (shows cupertino activity indicator), `icon`, `fullWidth`.

### AppSecondaryButton
- **Purpose**: Secondary action button. Default height is 52px.
- **Key Parameters**: same as above.

### AppOutlineButton
- **Purpose**: Outlined border action button for subtle visual weight. Default height is 52px.
- **Key Parameters**: same as above.

### AppTextButton
- **Purpose**: Simple text link action button.
- **Key Parameters**: `text`, `onPressed`, `icon`, `textColor`.

### AppIconButton
- **Purpose**: Minimal circular touch-optimized icon button.
- **Key Parameters**: `icon`, `onPressed`, `color`, `size`.

---

## 7. AppInputs (`lib/shared/widgets/inputs/app_inputs.dart`)
High-quality text inputs matching iOS forms.

### AppTextField
- **Purpose**: General text input field supporting error messages, validation, prefix/suffix icons.
- **Key Parameters**: `controller`, `labelText`, `hintText`, `helperText`, `errorText`, `validator`, `prefixIcon`, `suffixIcon`.

### AppPasswordField
- **Purpose**: Password input field with integrated visibility eye toggle.
- **Key Parameters**: `controller`, `labelText`, `validator`.

### AppSearchField
- **Purpose**: Rounded bar search field containing leading search glass and automatic text clear suffix button.
- **Key Parameters**: `controller`, `hintText`, `onChanged`, `onClear`.

---

## 8. AppCard (`lib/shared/widgets/cards/app_card.dart`)
- **Purpose**: Surface card container representing elevated containers. Corner radius is 18px. Uses spring-scale bounce on touch instead of Material ripples.
- **Key Parameters**:
  - `child`: Interior widgets.
  - `padding`/`borderRadius`: Styling configs (defaulting to AppSpacing.md / BorderRadius.circular(18)).
  - `hasShadow`: Toggles soft drop shadows.
  - `onTap`: Attaches touch response.

---

## 9. AppListTile (`lib/shared/widgets/lists/app_list_tile.dart`)
- **Purpose**: Table row item for lists, settings menus, and navigations.
- **Key Parameters**:
  - `leading`: Left icon/avatar.
  - `title`/`subtitle`: Primary and secondary textual rows.
  - `trailing`: Custom suffix (toggles, status badges) or automatically renders iOS chevron if `onTap` is attached.
  - `showDivider`: Appends bottom border line.

---

## 10. AppDialog (`lib/shared/widgets/dialogs/app_dialog.dart`)
- **Purpose**: iOS alert dialog panel system.
- **Key Static Methods**:
  - `AppDialog.showAlert(context, title, message)`: Alert dialog with single OK button.
  - `AppDialog.showConfirm(context, title, message, onConfirm)`: Dialog with Cancel and Confirm buttons (supporting destructive red coloration).

---

## 11. AppBottomSheet (`lib/shared/widgets/sheets/app_bottom_sheet.dart`)
- **Purpose**: Sheet drawer panel pulling up from bottom screen.
- **Key Static Methods**:
  - `AppBottomSheet.show(context, builder)`: Launches sheet with top-rounded border sheets, drag indicators, and safe area keyboard padding.

---

## 12. AppStates (`lib/shared/widgets/states/app_states.dart`)
Visual states handling async load conditions.

### AppLoading
- **Purpose**: Centered iOS Cupertino activity indicator.

### AppEmptyState
- **Purpose**: Dashboard error panel illustrating lack of results.
- **Key Parameters**: `icon`, `title`, `description`, `actionLabel`, `onActionPressed`.

### AppErrorState
- **Purpose**: Panel detailing API exception details.
- **Key Parameters**: `title`, `message`, `onRetry`.

---

## 13. AppNetworkImage (`lib/shared/widgets/images/app_image.dart`)
- **Purpose**: Centralized network image rendering component. Wraps `CachedNetworkImage` to enforce consistent loading behavior, placeholder styles, error widgets, and corner clips.
- **Key Parameters**:
  - `imageUrl`: Target internet image URL.
  - `fit`: BoxFit rendering rule (default: `BoxFit.cover`).
  - `width` / `height`: Optional size dimensions.
  - `borderRadius`: Optional border corner clipper to avoid wrapping with `ClipRRect`.
  - `placeholder` / `errorWidget`: Optional overrides for states.
