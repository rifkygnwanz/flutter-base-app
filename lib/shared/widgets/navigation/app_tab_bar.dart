import 'dart:ui';
import 'package:flutter/widgets.dart';
import '../../../core/theme/app_colors.dart';
import '../icons/app_icon.dart';
import '../text/app_text.dart';

class AppTabBarItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const AppTabBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class AppTabBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AppTabBarItem> items;

  const AppTabBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: colors.translucentSurface,
            border: Border(
              top: BorderSide(
                color: colors.border.withValues(alpha: 0.3),
                width: 0.5,
              ),
            ),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 49.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(items.length, (index) {
                  final item = items[index];
                  final isSelected = index == currentIndex;
                  final activeColor = isSelected
                      ? colors.primary
                      : colors.textSecondary;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onTap(index),
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppIcon(
                            isSelected ? item.activeIcon : item.icon,
                            size: 22,
                            color: activeColor,
                          ),
                          const SizedBox(height: 3),
                          AppText(
                            item.label,
                            variant: AppTextVariant.caption,
                            color: activeColor,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
