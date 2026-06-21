import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/storage/preferences.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

/// Provider that manages and persists the active [ThemeMode] selection.
final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(() {
  return ThemeModeNotifier();
});

/// Notifier handling the application's active [ThemeMode].
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final prefsService = ref.watch(preferencesServiceProvider);
    final savedMode = prefsService.getThemeMode();
    switch (savedMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  /// Update the active theme and persist it in [PreferencesService].
  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    String modeString = 'system';
    if (mode == ThemeMode.light) {
      modeString = 'light';
    } else if (mode == ThemeMode.dark) {
      modeString = 'dark';
    }
    final prefsService = ref.read(preferencesServiceProvider);
    await prefsService.saveThemeMode(modeString);
  }
}

/// The root application widget.
class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Base App Starter Kit',
      debugShowCheckedModeBanner: false,

      // Theme integration
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,

      // Routing configuration
      routerConfig: router,
    );
  }
}
