# AI Development Guideline

> [!IMPORTANT]
> This document is written specifically for **AI Coding Agents** (like Antigravity, GitHub Copilot, Gemini, Cursor, etc.) modifying or extending this codebase.

As an AI Agent, you MUST adhere strictly to the following architectural, visual, and developmental rules. Failure to do so will result in rejected pull requests.

---

## 1. Core Directives

1. **Read Documentation First**: Before proposing or generating any code changes, read the files in the `docs/` folder, especially `docs/architecture.md` and `docs/design_system.md`.
2. **Scan Existing Widgets**: Before creating *any* new user interface element, inspect the contents of `lib/shared/widgets/` to check if a suitable component already exists.
3. **No Duplicated Components**: You are forbidden from creating custom inputs, buttons, cards, list rows, headers, or alerts. Use `AppPrimaryButton`, `AppTextField`, `AppCard`, `AppListTile`, `AppDialog`, and `AppBottomSheet` exclusively.
4. **Follow the Design System**: Never write raw hex codes, `Colors.xyz`, double margins (`EdgeInsets.all(17)`), or custom `TextStyle` definitions. All stylings must resolve from our predefined systems:
   - Use `AppColors.of(context)` for colors.
   - Use `AppSpacing` for padding, margins, and gaps.
   - Use `AppTypography.of(context)` or `AppText` widgets for text styling.
   - Use `AppRadius` for borders and rounded corners.
   - Use `AppShadows` for shadows.
5. **Document Extensions**: If you create a new global reusable widget, you MUST update `docs/widget_catalog.md` and `docs/widget_usage.md` with descriptive parameters and code snippets.
6. **NEVER USE MATERIAL OR RAW IMAGE WIDGETS DIRECTLY**: Do not directly instantiate raw Material widgets, Material icons, Android navigation bars, or raw image downloaders (like `CachedNetworkImage` or `Image.network`) inside feature screens.

### Core Substitution Examples:

```text
Wrong:
ElevatedButton()

Correct:
AppPrimaryButton()
```

```text
Wrong:
Icons.home

Correct:
AppIcon(CupertinoIcons.house)
```

```text
Wrong:
BottomNavigationBar()

Correct:
AppTabBar()
```

```text
Wrong:
AppBar()

Correct:
AppNavigationBar()
```

```text
Wrong:
CachedNetworkImage(imageUrl: url)
Image.network(url)

Correct:
AppNetworkImage(imageUrl: url)
```

---

## 2. Code Generation Checklists

### When Generating a New Feature:
- Ensure the folder structure matches:
  - `features/new_feature/data/`
  - `features/new_feature/domain/`
  - `features/new_feature/presentation/`
- Register new feature screen paths in `lib/app/router/route_config.dart` and bind them to the router in `lib/app/router/app_router.dart`.
- Ensure all business models in `data/models/` use `@freezed` and generate serializers using `build_runner`.
- Implement repositories using the abstract interface pattern (defining interfaces in `domain/repositories/` and concrete implementation in `data/repositories/`).
- Use Riverpod state controllers (inside `presentation/controllers/`) to manage logic. Do not store mutable logic states inside widgets.

---

## 3. Formatting & Quality Checks
- Make sure to format all generated files using `fvm flutter format <file_path>`.
- Run analyzer check `fvm flutter analyze` to ensure there are no compilation errors or linter warnings.
