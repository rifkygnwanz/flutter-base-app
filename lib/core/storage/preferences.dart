import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider to access the [PreferencesService] instance.
///
/// This provider must be overridden in the [ProviderScope] of `main.dart`
/// during application bootstrap to provide a synchronously initialized instance.
final preferencesServiceProvider = Provider<PreferencesService>((ref) {
  throw UnimplementedError(
    'preferencesServiceProvider must be overridden in ProviderScope',
  );
});

/// A service to read and write persistent local preferences (e.g. app theme, locale, settings).
class PreferencesService {
  final SharedPreferences _prefs;

  PreferencesService(this._prefs);

  static const String _themeModeKey = 'theme_mode';
  static const String _localeKey = 'app_locale';

  /// Save the user's selected theme mode preference (light, dark, or system).
  Future<void> saveThemeMode(String mode) async {
    await _prefs.setString(_themeModeKey, mode);
  }

  /// Get the user's selected theme mode preference.
  String getThemeMode() {
    return _prefs.getString(_themeModeKey) ?? 'system';
  }

  /// Save the user's selected language locale.
  Future<void> saveLocale(String localeCode) async {
    await _prefs.setString(_localeKey, localeCode);
  }

  /// Get the user's saved language locale.
  String? getLocale() {
    return _prefs.getString(_localeKey);
  }

  // --- GENERAL PREFERENCE GETTERS & SETTERS ---

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  /// Clear all stored preferences.
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
