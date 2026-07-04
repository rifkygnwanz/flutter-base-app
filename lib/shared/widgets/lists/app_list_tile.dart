import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../icons/app_icon.dart';
import '../text/app_text.dart';

class AppListTile extends StatefulWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool showDivider;
  final VoidCallback? onTap;
  final double minHeight;

  const AppListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.showDivider = true,
    this.onTap,
    this.minHeight = 56.0,
  });

  @override
  State<AppListTile> createState() => _AppListTileState();
}

class _AppListTileState extends State<AppListTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    Widget content = Container(
      constraints: BoxConstraints(minHeight: widget.minHeight),
      color: _isPressed
          ? colors.border.withValues(alpha: 0.4)
          : const Color(0x00000000),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          if (widget.leading != null) ...[widget.leading!, AppSpacing.gapMd],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText.body(
                  widget.title,
                  fontWeight: FontWeight.w500,
                  color: colors.textPrimary,
                ),
                if (widget.subtitle != null) ...[
                  AppSpacing.gapXs,
                  AppText.subheadline(
                    widget.subtitle!,
                    color: colors.textSecondary,
                  ),
                ],
              ],
            ),
          ),
          if (widget.trailing != null) ...[
            AppSpacing.gapMd,
            widget.trailing!,
          ] else if (widget.onTap != null) ...[
            AppSpacing.gapMd,
            AppIcon(
              CupertinoIcons.chevron_forward,
              size: 14,
              color: colors.textTertiary,
            ),
          ],
        ],
      ),
    );

    if (widget.onTap != null) {
      content = GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: content,
      );
    }

    if (widget.showDivider) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          content,
          Container(
            height: 0.5,
            margin: EdgeInsets.only(left: widget.leading != null ? 56.0 : 16.0),
            color: colors.border.withValues(alpha: 0.5),
          ),
        ],
      );
    }

    return content;
  }
}
