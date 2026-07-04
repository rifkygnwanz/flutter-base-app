import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../icons/app_icon.dart';
import '../text/app_text.dart';

class _TouchBounceInteraction extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool enabled;

  const _TouchBounceInteraction({
    required this.child,
    required this.onTap,
    this.enabled = true,
  });

  @override
  State<_TouchBounceInteraction> createState() =>
      _TouchBounceInteractionState();
}

class _TouchBounceInteractionState extends State<_TouchBounceInteraction>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enabled && widget.onTap != null) {
      setState(() => _isPressed = true);
      _controller.forward();
      HapticFeedback.lightImpact();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enabled && widget.onTap != null) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.enabled && widget.onTap != null) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.enabled ? widget.onTap : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 80),
              opacity: _isPressed ? 0.75 : (widget.enabled ? 1.0 : 0.4),
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

class AppPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  final bool enabled;
  final IconData? icon;
  final bool fullWidth;
  final double? width;
  final double height;

  const AppPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.loading = false,
    this.enabled = true,
    this.icon,
    this.fullWidth = true,
    this.width,
    this.height = 52.0,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isButtonEnabled = enabled && !loading && onPressed != null;

    Widget child = Container(
      width: fullWidth ? double.infinity : width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isButtonEnabled
            ? colors.primary
            : colors.border.withValues(alpha: 0.4),
        borderRadius: AppRadius.borderMd,
      ),
      padding: AppSpacing.edgeInsetsHorizontalMd,
      child: loading
          ? const CupertinoActivityIndicator(color: Color(0xFFFFFFFF))
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  AppIcon(icon!, color: const Color(0xFFFFFFFF), size: 20),
                  AppSpacing.gapSm,
                ],
                Flexible(
                  child: AppText.headline(
                    text,
                    color: const Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
    );

    return _TouchBounceInteraction(
      onTap: onPressed,
      enabled: isButtonEnabled,
      child: child,
    );
  }
}

class AppSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  final bool enabled;
  final IconData? icon;
  final bool fullWidth;
  final double? width;
  final double height;

  const AppSecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.loading = false,
    this.enabled = true,
    this.icon,
    this.fullWidth = true,
    this.width,
    this.height = 52.0,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isButtonEnabled = enabled && !loading && onPressed != null;

    Widget child = Container(
      width: fullWidth ? double.infinity : width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isButtonEnabled
            ? colors.secondary
            : colors.border.withValues(alpha: 0.4),
        borderRadius: AppRadius.borderMd,
      ),
      padding: AppSpacing.edgeInsetsHorizontalMd,
      child: loading
          ? const CupertinoActivityIndicator(color: Color(0xFFFFFFFF))
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  AppIcon(icon!, color: const Color(0xFFFFFFFF), size: 20),
                  AppSpacing.gapSm,
                ],
                Flexible(
                  child: AppText.headline(
                    text,
                    color: const Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
    );

    return _TouchBounceInteraction(
      onTap: onPressed,
      enabled: isButtonEnabled,
      child: child,
    );
  }
}

class AppOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  final bool enabled;
  final IconData? icon;
  final bool fullWidth;
  final double? width;
  final double height;

  const AppOutlineButton({
    super.key,
    required this.text,
    this.onPressed,
    this.loading = false,
    this.enabled = true,
    this.icon,
    this.fullWidth = true,
    this.width,
    this.height = 52.0,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isButtonEnabled = enabled && !loading && onPressed != null;

    Widget child = Container(
      width: fullWidth ? double.infinity : width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0x00000000),
        borderRadius: AppRadius.borderMd,
        border: Border.all(
          color: isButtonEnabled ? colors.primary : colors.border,
          width: 1.2,
        ),
      ),
      padding: AppSpacing.edgeInsetsHorizontalMd,
      child: loading
          ? CupertinoActivityIndicator(color: colors.primary)
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  AppIcon(
                    icon!,
                    color: isButtonEnabled
                        ? colors.primary
                        : colors.textSecondary,
                    size: 20,
                  ),
                  AppSpacing.gapSm,
                ],
                Flexible(
                  child: AppText.headline(
                    text,
                    color: isButtonEnabled
                        ? colors.primary
                        : colors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
    );

    return _TouchBounceInteraction(
      onTap: onPressed,
      enabled: isButtonEnabled,
      child: child,
    );
  }
}

class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  final bool enabled;
  final IconData? icon;
  final Color? textColor;

  const AppTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.loading = false,
    this.enabled = true,
    this.icon,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isButtonEnabled = enabled && !loading && onPressed != null;
    final activeColor = textColor ?? colors.primary;

    Widget child = Container(
      height: 44.0,
      padding: AppSpacing.edgeInsetsHorizontalSm,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (loading) ...[
            CupertinoActivityIndicator(color: activeColor),
          ] else ...[
            if (icon != null) ...[
              AppIcon(
                icon!,
                color: isButtonEnabled ? activeColor : colors.textSecondary,
                size: 18,
              ),
              AppSpacing.gapXs,
            ],
            AppText.body(
              text,
              color: isButtonEnabled ? activeColor : colors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ],
        ],
      ),
    );

    return _TouchBounceInteraction(
      onTap: onPressed,
      enabled: isButtonEnabled,
      child: child,
    );
  }
}

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool enabled;
  final Color? color;
  final double size;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.enabled = true,
    this.color,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isButtonEnabled = enabled && onPressed != null;
    final activeColor = color ?? colors.primary;

    Widget child = Container(
      width: 44.0,
      height: 44.0,
      alignment: Alignment.center,
      child: AppIcon(
        icon,
        color: isButtonEnabled ? activeColor : colors.textSecondary,
        size: size,
      ),
    );

    return _TouchBounceInteraction(
      onTap: onPressed,
      enabled: isButtonEnabled,
      child: child,
    );
  }
}
