import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../states/app_states.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;

  final bool safeAreaTop;
  final bool safeAreaBottom;
  final bool safeAreaLeft;
  final bool safeAreaRight;

  final bool isLoading;
  final String? loadingMessage;

  final bool extendBodyBehindBottomBar;

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

    Widget mainContent = SafeArea(
      top: safeAreaTop,
      bottom: safeAreaBottom,
      left: safeAreaLeft,
      right: safeAreaRight,
      child: body,
    );

    Widget stackedBody = Stack(
      children: [
        Positioned.fill(child: mainContent),
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: const Color(0x4D000000),
              child: AppLoading(
                message: loadingMessage,
                color: const Color(0xFFFFFFFF),
              ),
            ),
          ),
      ],
    );

    Widget layedOutContent;
    if (appBar != null) {
      layedOutContent = Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
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

    final bottomPadding =
        (bottomNavigationBar != null && !extendBodyBehindBottomBar)
        ? (49.0 + MediaQuery.of(context).padding.bottom)
        : 0.0;

    final fabBottomPadding = bottomNavigationBar != null
        ? (49.0 + MediaQuery.of(context).padding.bottom)
        : 0.0;

    Widget scaffoldContent = Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: layedOutContent,
          ),
        ),
        if (bottomNavigationBar != null)
          Positioned(left: 0, right: 0, bottom: 0, child: bottomNavigationBar!),
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
