# Reusable Widget Usage Examples

This guide provides copy-pasteable code snippets demonstrating how to implement our custom widgets.

---

## 1. AppText (Typography)

Use the standard constructor or specialized named constructors:

```dart
// Named constructors
const AppText.largeTitle('Dashboard')
const AppText.titleMedium('Profile Details')
const AppText.headline('Save Changes')
const AppText.body('Lorem ipsum dolor sit amet...')
const AppText.caption('Last sync: 2 mins ago')

// Override color and weight
AppText.body(
  'Required Field',
  color: AppColors.of(context).error,
  fontWeight: FontWeight.bold,
)
```

---

## 2. Buttons

All buttons support loading, icons, and disabled states.

```dart
// Primary Button (Full-width by default)
AppPrimaryButton(
  text: 'Sign In',
  onPressed: () => _handleSignIn(),
)

// Secondary Button
AppSecondaryButton(
  text: 'Add to Cart',
  icon: CupertinoIcons.cart_badge_plus,
  onPressed: () => _handleAddToCart(),
)

// Outlined Button (Custom Width)
AppOutlineButton(
  text: 'Cancel',
  fullWidth: false,
  width: 150,
  onPressed: () => Navigator.pop(context),
)

// Text Button
AppTextButton(
  text: 'Forgot Password?',
  onPressed: () => _goToForgotPassword(),
)

// Icon Button (Standard HIG target)
AppIconButton(
  icon: CupertinoIcons.xmark,
  onPressed: () => Navigator.pop(context),
)

// Button in Loading State
AppPrimaryButton(
  text: 'Register',
  loading: true,
  onPressed: () {}, // Action ignored during load
)
```

---

## 3. Input Components

Use inputs within Form/Validation layouts:

```dart
final _emailController = TextEditingController();

AppTextField(
  controller: _emailController,
  labelText: 'Email Address',
  hintText: 'name@example.com',
  prefixIcon: const AppIcon(CupertinoIcons.mail),
  keyboardType: TextInputType.emailAddress,
  validator: (val) {
    if (val == null || val.isEmpty) return 'Email is required';
    return null;
  },
)

AppPasswordField(
  labelText: 'Password',
  validator: (val) => val != null && val.length < 8 ? 'Password too short' : null,
)

AppSearchField(
  hintText: 'Search products...',
  onChanged: (query) => _runSearch(query),
)
```

---

## 4. Cards & Lists

Create table menus and dashboard layouts easily:

```dart
AppCard(
  onTap: () => _openDetails(),
  child: Column(
    children: [
      AppText.titleSmall('Product Summary'),
      AppSpacing.gapSm,
      AppText.body('Detailed description goes here.'),
    ],
  ),
)

AppListTile(
  leading: const AppIcon(CupertinoIcons.person),
  title: 'Edit Profile',
  subtitle: 'Update username and email',
  onTap: () => _goToEditProfile(), // Automatically draws trailing chevron arrow
)

AppListTile(
  leading: const AppIcon(CupertinoIcons.bell),
  title: 'Push Notifications',
  trailing: CupertinoSwitch(
    value: _notificationsEnabled,
    onChanged: (val) => _toggleNotifications(val),
  ),
  showDivider: false, // Disables bottom separator line
)
```

---

## 5. Dialogs & Bottom Sheets

Trigger overlays modally:

```dart
// Alert Dialog
AppDialog.showAlert(
  context: context,
  title: 'Sync Complete',
  message: 'All offline records have been uploaded successfully.',
);

// Confirmation Dialog
AppDialog.showConfirm(
  context: context,
  title: 'Delete Account?',
  message: 'This action is irreversible. All user data will be wiped.',
  confirmLabel: 'Delete',
  isDestructive: true, // colors confirm red
  onConfirm: () => _deleteUserAccount(),
);

// Bottom Sheet Panel
AppBottomSheet.show(
  context: context,
  builder: (sheetContext) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      AppText.titleSmall('Select Language'),
      AppSpacing.gapMd,
      AppListTile(
        title: 'English',
        onTap: () => Navigator.pop(sheetContext, 'en'),
      ),
      AppListTile(
        title: 'Spanish',
        onTap: () => Navigator.pop(sheetContext, 'es'),
        showDivider: false,
      ),
    ],
  ),
);
```

---

## 6. AppScaffold (Root Screens)

Use `AppScaffold` as the root widget for every page in `presentation/pages/`:

```dart
class MyFeaturePage extends StatelessWidget {
  const MyFeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const AppNavigationBar(
        title: 'Settings',
        backButtonText: 'Home',
      ),
      isLoading: false, // set true during API loading to block interactions
      body: ListView(
        children: [
          AppListTile(
            title: 'Account Settings',
            onTap: () {},
          ),
          AppListTile(
            title: 'Privacy Policy',
            onTap: () {},
            showDivider: false,
          ),
        ],
      ),
    );
  }
}
```

---

## 7. AppNetworkImage (Images)

Use `AppNetworkImage` to display external/network images securely and uniformly with automatic caching:

```dart
// Simple network image
AppNetworkImage(
  imageUrl: 'https://example.com/product.jpg',
  height: 200,
  width: double.infinity,
)

// Network image with specific border corners and custom BoxFit
AppNetworkImage(
  imageUrl: 'https://example.com/avatar.png',
  width: 50,
  height: 50,
  fit: BoxFit.cover,
  borderRadius: BorderRadius.circular(25), // circular clip
)
```
