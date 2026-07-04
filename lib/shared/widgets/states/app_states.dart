import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../buttons/app_buttons.dart';
import '../icons/app_icon.dart';
import '../text/app_text.dart';

class AppLoading extends StatelessWidget {
  final String? message;
  final Color? color;

  const AppLoading({super.key, this.message, this.color});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final spinnerColor = color ?? colors.primary;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoActivityIndicator(color: spinnerColor, radius: 14),
          if (message != null) ...[
            AppSpacing.gapMd,
            AppText.subheadline(
              message!,
              color: colors.textSecondary,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class AppEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onActionPressed;

  const AppEmptyState({
    super.key,
    this.icon = CupertinoIcons.tray,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(icon, size: 72, color: colors.textTertiary),
            AppSpacing.gapLg,
            AppText.title2(
              title,
              textAlign: TextAlign.center,
              color: colors.textPrimary,
            ),
            AppSpacing.gapSm,
            AppText.body(
              description,
              textAlign: TextAlign.center,
              color: colors.textSecondary,
            ),
            if (actionLabel != null && onActionPressed != null) ...[
              AppSpacing.gapLg,
              AppPrimaryButton(
                text: actionLabel!,
                onPressed: onActionPressed!,
                fullWidth: false,
                width: 200,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AppErrorState extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;

  const AppErrorState({
    super.key,
    this.title = 'Something went wrong',
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(
              CupertinoIcons.exclamationmark_triangle,
              size: 72,
              color: colors.error,
            ),
            AppSpacing.gapLg,
            AppText.title2(
              title,
              textAlign: TextAlign.center,
              color: colors.textPrimary,
            ),
            AppSpacing.gapSm,
            AppText.body(
              message,
              textAlign: TextAlign.center,
              color: colors.textSecondary,
            ),
            if (onRetry != null) ...[
              AppSpacing.gapLg,
              AppPrimaryButton(
                text: 'Try Again',
                onPressed: onRetry!,
                fullWidth: false,
                width: 160,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
