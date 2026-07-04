import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../text/app_text.dart';

class AppDialogAction {
  final String label;
  final VoidCallback onPressed;
  final bool isDestructive;
  final bool isDefault;

  const AppDialogAction({
    required this.label,
    required this.onPressed,
    this.isDestructive = false,
    this.isDefault = false,
  });
}

class AppDialog extends StatelessWidget {
  final String title;
  final String? message;
  final Widget? content;
  final List<AppDialogAction> actions;

  const AppDialog({
    super.key,
    required this.title,
    this.message,
    this.content,
    required this.actions,
  });

  static Future<void> showAlert({
    required BuildContext context,
    required String title,
    String? message,
    String okLabel = 'OK',
    VoidCallback? onOk,
  }) async {
    await showCupertinoDialog(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        message: message,
        actions: [
          AppDialogAction(
            label: okLabel,
            isDefault: true,
            onPressed: () {
              Navigator.pop(context);
              if (onOk != null) onOk();
            },
          ),
        ],
      ),
    );
  }

  static Future<void> showConfirm({
    required BuildContext context,
    required String title,
    String? message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) async {
    await showCupertinoDialog(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        message: message,
        actions: [
          AppDialogAction(
            label: cancelLabel,
            onPressed: () {
              Navigator.pop(context);
              if (onCancel != null) onCancel();
            },
          ),
          AppDialogAction(
            label: confirmLabel,
            isDestructive: isDestructive,
            isDefault: !isDestructive,
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return CupertinoAlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: AppText.headline(
          title,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
          color: colors.textPrimary,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (message != null)
            AppText.subheadline(
              message!,
              textAlign: TextAlign.center,
              color: colors.textSecondary,
            ),
          if (content != null) ...[AppSpacing.gapMd, content!],
        ],
      ),
      actions: actions.map((action) {
        return CupertinoDialogAction(
          onPressed: action.onPressed,
          isDefaultAction: action.isDefault,
          isDestructiveAction: action.isDestructive,
          child: AppText.body(
            action.label,
            color: action.isDestructive
                ? colors.error
                : (action.isDefault ? colors.primary : colors.textSecondary),
            fontWeight: action.isDefault ? FontWeight.bold : FontWeight.normal,
          ),
        );
      }).toList(),
    );
  }
}
