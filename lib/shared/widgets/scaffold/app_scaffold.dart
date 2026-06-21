import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../states/app_states.dart';

/// Centralized base scaffold for all feature screens.
///
/// Replaces standard Material Scaffold with a custom Cupertino HIG stack layout
/// to support frosted glass navigation bars and absolute control over rendering.
class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;

  // Safe Area configuration
  final bool safeAreaTop;
  final bool safeAreaBottom;
  final bool safeAreaLeft;
  final bool safeAreaRight;

  // Loading overlay configuration
  final bool isLoading;
  final String? loadingMessage;

  // New configuration to allow body to flow behind the bottom navigation bar (iOS design)
  final bool extendBodyBehindBottomBar;

  // New configuration to dismiss the keyboard when tapping outside of inputs
  final bool dismissKeyboardOnTap;

  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
    this.safeAreaLeft = true,
    this.safeAreaRight = true,
    this.isLoading = false,
    this.loadingMessage,
    this.extendBodyBehindBottomBar = false,
    this.dismissKeyboardOnTap = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final typography = AppTypography.of(context);

    // Build the body, accounting for safe areas
    Widget mainContent = SafeArea(
      top: safeAreaTop,
      bottom: safeAreaBottom,
      left: safeAreaLeft,
      right: safeAreaRight,
      child: body,
    );

    // Stack to support blocking loading overlay
    Widget stackedBody = Stack(
      children: [
        Positioned.fill(child: mainContent),
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: const Color(0x4D000000), // dims behind modal (alpha 0.3)
              child: AppLoading(
                message: loadingMessage,
                color: const Color(0xFFFFFFFF),
              ),
            ),
          ),
      ],
    );

    // In iOS HIG, translucent app bars float over the content (allowing content to scroll underneath).
    Widget layedOutContent;
    if (appBar != null) {
      layedOutContent = Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                // Push down by the app bar height if we are enforcing top safe area.
                // Otherwise, let the body flow behind the translucent app bar (top: 0).
                top: safeAreaTop ? appBar!.preferredSize.height : 0.0,
              ),
              child: stackedBody,
            ),
          ),
          Positioned(top: 0, left: 0, right: 0, child: appBar!),
        ],
      );
    } else {
      layedOutContent = stackedBody;
    }

    final bottomPadding = (bottomNavigationBar != null && !extendBodyBehindBottomBar)
        ? (49.0 +
              MediaQuery.of(
                context,
              ).padding.bottom) // TabBar height + iOS home indicator
        : 0.0;

    final fabBottomPadding = bottomNavigationBar != null
        ? (49.0 +
              MediaQuery.of(
                context,
              ).padding.bottom) // TabBar height + iOS home indicator
        : 0.0;

    // Stack bottomNavigationBar and floatingActionButton
    Widget scaffoldContent = Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: layedOutContent,
          ),
        ),
        if (bottomNavigationBar != null)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: bottomNavigationBar!,
          ),
        if (floatingActionButton != null)
          Positioned(
            right: AppSpacing.lg,
            bottom: fabBottomPadding + AppSpacing.lg,
            child: floatingActionButton!,
          ),
      ],
    );

    if (dismissKeyboardOnTap) {
      scaffoldContent = GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.translucent,
        child: scaffoldContent,
      );
    }

    // Stack bottomNavigationBar and floatingActionButton wrapped in DefaultTextStyle
    // to prevent default yellow double-underlines on text.
    return Container(
      color: backgroundColor ?? colors.background,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: DefaultTextStyle(
          style: typography.body.copyWith(color: colors.textPrimary),
          child: scaffoldContent,
        ),
      ),
    );
  }
}
