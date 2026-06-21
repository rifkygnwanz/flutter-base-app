import 'package:flutter/widgets.dart';
import '../../../core/theme/app_colors.dart';

/// Reusable Icon Component following iOS HIG guidelines.
///
/// Developers are prohibited from using Material Icons. Always supply
/// [CupertinoIcons] or [LucideIcons] to this component.
class AppIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? color;

  const AppIcon(this.icon, {super.key, this.size = 24.0, this.color});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final iconColor = color ?? colors.textPrimary;

    return Icon(icon, size: size, color: iconColor);
  }
}
