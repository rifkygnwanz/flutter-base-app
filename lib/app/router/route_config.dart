/// Centralized route paths and names configuration.
class RouteConfig {
  RouteConfig._();

  // --- AUTH ROUTES ---
  static const String loginPath = '/login';
  static const String loginName = 'login';

  static const String registerPath = '/register';
  static const String registerName = 'register';

  // --- APP SHELL (NESTED TABS) ROUTES ---
  static const String homePath = '/home';
  static const String homeName = 'home';

  static const String searchPath = '/search';
  static const String searchName = 'search';

  static const String settingsPath = '/settings';
  static const String settingsName = 'settings';

  // --- DETAILS ROUTES ---
  static const String detailsPath = 'details'; // Sub-route
  static const String detailsName = 'details';
}
