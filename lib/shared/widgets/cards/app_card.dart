import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';

/// A premium, customizable card container following iOS HIG elevation styles.
///
/// Material ink ripples are completely removed. If [onTap] is provided, the card
/// responds with an HIG-compliant scale down and opacity bounce animation.
class AppCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final bool hasShadow;
  final Border? border;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const AppCard({
    super.key,
    required this.child,
    this.padding = AppSpacing.edgeInsetsMd,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(18.0),
    ), // iOS 18px radius
    this.color,
    this.hasShadow = true,
    this.border,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      setState(() => _isPressed = true);
      _controller.forward();
      HapticFeedback.lightImpact();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onTap != null) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.onTap != null) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    Widget cardContent = Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.color ?? colors.surface,
        borderRadius: widget.borderRadius,
        border:
            widget.border ??
            Border.all(color: colors.border.withValues(alpha: 0.3), width: 0.5),
        boxShadow: widget.hasShadow ? AppShadows.listCard : null,
      ),
      child: widget.child,
    );

    if (widget.onTap != null) {
      return GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: _isPressed ? 0.92 : 1.0,
                child: child,
              ),
            );
          },
          child: cardContent,
        ),
      );
    }

    return cardContent;
  }
}
