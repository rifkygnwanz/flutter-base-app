import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../icons/app_icon.dart';
import '../text/app_text.dart';

class AppNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final bool showBackButton;
  final String? backButtonText;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool transparent;
  final Color? backgroundColor;

  const AppNavigationBar({
    super.key,
    this.title,
    this.titleWidget,
    this.showBackButton = true,
    this.backButtonText,
    this.actions,
    this.bottom,
    this.transparent = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    Widget? leadingWidget;
    final canPop = GoRouter.of(context).canPop();
    if (showBackButton && canPop) {
      leadingWidget = GestureDetector(
        onTap: () => context.pop(),
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(CupertinoIcons.back, size: 22, color: colors.primary),
            if (backButtonText != null) ...[
              const SizedBox(width: 4),
              AppText.body(backButtonText!, color: colors.primary),
            ],
          ],
        ),
      );
    }

    final centerTitleWidget =
        titleWidget ??
        (title != null
            ? AppText.headline(
                title!,
                fontWeight: FontWeight.w600,
                color: colors.textPrimary,
              )
            : const SizedBox.shrink());

    Widget barContent = Container(
      height: 44.0,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: NavigationToolbar(
        leading: leadingWidget,
        middle: centerTitleWidget,
        trailing: actions != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: actions!.map((w) {
                  return Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.sm),
                    child: w,
                  );
                }).toList(),
              )
            : null,
        centerMiddle: true,
        middleSpacing: NavigationToolbar.kMiddleSpacing,
      ),
    );

    if (bottom != null) {
      barContent = Column(
        mainAxisSize: MainAxisSize.min,
        children: [barContent, bottom!],
      );
    }

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          decoration: transparent
              ? null
              : BoxDecoration(
                  color: backgroundColor ?? colors.translucentSurface,
                  border: Border(
                    bottom: BorderSide(
                      color: colors.border.withValues(alpha: 0.3),
                      width: 0.5,
                    ),
                  ),
                ),
          child: SafeArea(bottom: false, child: barContent),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(44.0 + (bottom?.preferredSize.height ?? 0.0));
}
