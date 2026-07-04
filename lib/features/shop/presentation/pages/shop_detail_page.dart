import 'dart:ui';
import 'package:flutter/cupertino.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_bar/app_navigation_bar.dart';
import '../../../../shared/widgets/buttons/app_buttons.dart';
import '../../../../shared/widgets/icons/app_icon.dart';
import '../../../../shared/widgets/images/app_image.dart';
import '../../../../shared/widgets/scaffold/app_scaffold.dart';
import '../../../../shared/widgets/sheets/app_bottom_sheet.dart';
import '../../../../shared/widgets/text/app_text.dart';
import '../controllers/product_controller.dart';

class ShopDetailPage extends StatelessWidget {
  final Product product;

  const ShopDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    final topPadding = MediaQuery.of(context).padding.top + 44.0;

    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return AppScaffold(
      safeAreaTop: false,
      safeAreaBottom: false,
      appBar: AppNavigationBar(
        title: product.name,
        backButtonText: 'Shop',
        showBackButton: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                top: topPadding,
                bottom: 120.0 + bottomPadding,
              ),
              children: [
                AppNetworkImage(
                  imageUrl: product.imageUrl,
                  height: 320,
                  width: double.infinity,
                ),

                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: AppText.caption(
                          product.category.toUpperCase(),
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSpacing.gapMd,

                      AppText.title1(
                        product.name,
                        color: colors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      AppSpacing.gapSm,

                      AppText.title2(
                        '\$${product.price.toStringAsFixed(0)}',
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      AppSpacing.gapLg,

                      Container(
                        height: 0.5,
                        color: colors.border.withValues(alpha: 0.5),
                      ),
                      AppSpacing.gapLg,

                      AppText.headline(
                        'Overview',
                        color: colors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      AppSpacing.gapSm,

                      AppText.body(
                        product.description,
                        color: colors.textSecondary,
                        height: 1.5,
                      ),
                      AppSpacing.gapLg,

                      _buildSpecRow(context, 'Condition', 'New in Box'),
                      _buildSpecRow(
                        context,
                        'Warranty',
                        'Apple 1-Year Limited',
                      ),
                      _buildSpecRow(
                        context,
                        'Delivery',
                        'Free express shipping',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.md + bottomPadding,
                  ),
                  decoration: BoxDecoration(
                    color: colors.translucentSurface,
                    border: Border(
                      top: BorderSide(
                        color: colors.border.withValues(alpha: 0.3),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText.caption(
                              'TOTAL PRICE',
                              color: colors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 2),
                            AppText.title2(
                              '\$${product.price.toStringAsFixed(0)}',
                              color: colors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: AppPrimaryButton(
                          text: 'Add to Bag',
                          icon: CupertinoIcons.shopping_cart,
                          onPressed: () {
                            AppBottomSheet.show(
                              context: context,
                              builder: (sheetContext) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSpacing.md,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppIcon(
                                      CupertinoIcons.checkmark_circle,
                                      size: 48,
                                      color: colors.success,
                                    ),
                                    AppSpacing.gapMd,
                                    AppText.title2('Added to Bag'),
                                    AppSpacing.gapSm,
                                    AppText.body(
                                      '${product.name} is added to your shopping bag.',
                                    ),
                                    AppSpacing.gapLg,
                                    AppPrimaryButton(
                                      text: 'OK',
                                      onPressed: () =>
                                          Navigator.pop(sheetContext),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecRow(BuildContext context, String title, String value) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.subheadline(title, color: colors.textSecondary),
              AppText.subheadline(
                value,
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(height: 0.5, color: colors.border.withValues(alpha: 0.3)),
        ],
      ),
    );
  }
}
