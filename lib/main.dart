import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'core/storage/preferences.dart';

void main() async {
  // Enforce flutter binding initialization for native plugins
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment configurations from root .env file
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    // If .env is missing or corrupt in release build, we log and fall back to defaults
    debugPrint(
      'Warning: Could not load .env file. Falling back to default settings: $e',
    );
  }

  // Pre-initialize SharedPreferences for synchronous usage in Riverpod
  final sharedPreferences = await SharedPreferences.getInstance();
  final preferencesService = PreferencesService(sharedPreferences);

  runApp(
    ProviderScope(
      overrides: [
        // Inject the initialized PreferencesService instance synchronously
        preferencesServiceProvider.overrideWithValue(preferencesService),
      ],
      child: const MainApp(),
    ),
  );
}
