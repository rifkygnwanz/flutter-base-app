import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

/// Central bottom sheet wrapper styled according to Apple HIG.
///
/// Completely eliminates Material dependencies by utilizing showCupertinoModalPopup.
class AppBottomSheet extends StatelessWidget {
  final Widget child;
  final bool showDragHandle;
  final EdgeInsetsGeometry? padding;

  const AppBottomSheet({
    super.key,
    required this.child,
    this.showDragHandle = true,
    this.padding = const EdgeInsets.all(AppSpacing.md),
  });

  /// Displays the custom bottom sheet modally using Cupertino modal popups.
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isDismissible = true,
  }) {
    return showCupertinoModalPopup<T>(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) => AppBottomSheet(child: builder(context)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final typography = AppTypography.of(context);

    return DefaultTextStyle(
      style: typography.body.copyWith(color: colors.textPrimary),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: AppRadius.borderTopLg,
        ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: MediaQuery.of(
            context,
          ).viewInsets, // Adjust for keyboard overlay
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showDragHandle) ...[
                AppSpacing.gapSm,
                // iOS drag handle visual indicator
                Container(
                  width: 36.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: colors.border,
                    borderRadius: AppRadius.borderCircular,
                  ),
                ),
                AppSpacing.gapSm,
              ],
              Flexible(
                child: Padding(
                  padding: padding ?? EdgeInsets.zero,
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}
