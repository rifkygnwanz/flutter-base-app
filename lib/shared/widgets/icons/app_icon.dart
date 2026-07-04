import 'package:flutter/widgets.dart';
import '../../../core/theme/app_colors.dart';

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
