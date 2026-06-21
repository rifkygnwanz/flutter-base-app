import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/storage/secure_storage.dart';
import '../../features/shop/presentation/controllers/product_controller.dart';
import '../../features/shop/presentation/pages/shop_detail_page.dart';
import '../../features/shop/presentation/pages/shop_home_page.dart';
import '../../shared/widgets/app_bar/app_navigation_bar.dart';
import '../../shared/widgets/navigation/app_tab_bar.dart';
import '../../shared/widgets/scaffold/app_scaffold.dart';
import '../../shared/widgets/text/app_text.dart';
import 'route_config.dart';

// Global key for root navigator
final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

// Provider for GoRouter
final routerProvider = Provider<GoRouter>((ref) {
  final secureStorage = ref.watch(secureStorageServiceProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteConfig.homePath,
    debugLogDiagnostics: true,

    redirect: (context, state) async {
      final token = await secureStorage.getAccessToken();
      final isLoggedIn = token != null && token.isNotEmpty;

      final goingToLogin =
          state.matchedLocation == RouteConfig.loginPath ||
          state.matchedLocation == RouteConfig.registerPath;

      if (!isLoggedIn && !goingToLogin) {
        // Redirection disabled by default to make starter kit immediately reviewable.
        // return RouteConfig.loginPath;
      }

      if (isLoggedIn && goingToLogin) {
        return RouteConfig.homePath;
      }

      return null;
    },

    routes: [
      // Auth routes
      GoRoute(
        path: RouteConfig.loginPath,
        name: RouteConfig.loginName,
        builder: (context, state) =>
            const _PreviewScreen(title: 'Login Screen'),
      ),
      GoRoute(
        path: RouteConfig.registerPath,
        name: RouteConfig.registerName,
        builder: (context, state) =>
            const _PreviewScreen(title: 'Register Screen'),
      ),

      // Stateful nested navigation shell for tabbed interface (HIG pattern)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return _ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Home tab branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteConfig.homePath,
                name: RouteConfig.homeName,
                builder: (context, state) => const ShopHomePage(),
                routes: [
                  GoRoute(
                    path: RouteConfig.detailsPath,
                    name: RouteConfig.detailsName,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) {
                      final product = state.extra as Product;
                      return ShopDetailPage(product: product);
                    },
                  ),
                ],
              ),
            ],
          ),

          // Search tab branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteConfig.searchPath,
                name: RouteConfig.searchName,
                builder: (context, state) =>
                    const _PreviewScreen(title: 'Search Tab'),
              ),
            ],
          ),

          // Settings tab branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteConfig.settingsPath,
                name: RouteConfig.settingsName,
                builder: (context, state) =>
                    const _PreviewScreen(title: 'Settings Tab'),
              ),
            ],
          ),
        ],
      ),
    ],

    errorBuilder: (context, state) => AppScaffold(
      body: Center(child: AppText.body('No route defined for ${state.uri}')),
    ),
  );
});

/// A persistent shell wrapper with AppTabBar.
class _ScaffoldWithNavBar extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const _ScaffoldWithNavBar({required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      safeAreaTop: false,
      safeAreaBottom: false,
      extendBodyBehindBottomBar: true,
      body: navigationShell,
      bottomNavigationBar: AppTabBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          if (index == navigationShell.currentIndex) {
            // If already on the tab, trigger action (like scroll to top)
            if (index == 0) {
              ref.read(homeScrollTriggerProvider.notifier).trigger();
            }
          } else {
            navigationShell.goBranch(
              index,
              initialLocation: true,
            );
          }
        },
        items: const [
          AppTabBarItem(
            icon: CupertinoIcons.house,
            activeIcon: CupertinoIcons.house_fill,
            label: 'Home',
          ),
          AppTabBarItem(
            icon: CupertinoIcons.search,
            activeIcon: CupertinoIcons.search,
            label: 'Search',
          ),
          AppTabBarItem(
            icon: CupertinoIcons.settings,
            activeIcon: CupertinoIcons.settings_solid,
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

/// A private placeholder screen used for navigation demonstration.
class _PreviewScreen extends StatelessWidget {
  final String title;

  const _PreviewScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppNavigationBar(title: title, showBackButton: true),
      body: Center(child: AppText.title1(title)),
    );
  }
}
