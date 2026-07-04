import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../app/router/route_config.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/buttons/app_buttons.dart';
import '../../../../shared/widgets/cards/app_card.dart';
import '../../../../shared/widgets/dialogs/app_dialog.dart';
import '../../../../shared/widgets/icons/app_icon.dart';
import '../../../../shared/widgets/images/app_image.dart';
import '../../../../shared/widgets/inputs/app_inputs.dart';
import '../../../../shared/widgets/scaffold/app_scaffold.dart';
import '../../../../shared/widgets/sheets/app_bottom_sheet.dart';
import '../../../../shared/widgets/states/app_states.dart';
import '../../../../shared/widgets/text/app_text.dart';
import '../controllers/product_controller.dart';

class FlashSaleTimer extends StatefulWidget {
  const FlashSaleTimer({super.key});

  @override
  State<FlashSaleTimer> createState() => _FlashSaleTimerState();
}

class _FlashSaleTimerState extends State<FlashSaleTimer> {
  int _seconds = 9930;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFFFECEF),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFFF3B30), width: 0.5),
      ),
      child: Text(
        _formatDuration(_seconds),
        style: const TextStyle(
          color: Color(0xFFFF3B30),
          fontSize: 9,
          fontWeight: FontWeight.bold,
          fontFeatures: [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}

class ShopHomePage extends ConsumerStatefulWidget {
  const ShopHomePage({super.key});

  @override
  ConsumerState<ShopHomePage> createState() => _ShopHomePageState();
}

class _ShopHomePageState extends ConsumerState<ShopHomePage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final shopState = ref.watch(shopControllerProvider);
    final shopNotifier = ref.read(shopControllerProvider.notifier);

    ref.listen<int>(homeScrollTriggerProvider, (previous, next) {
      if (next > 0 && _scrollController.hasClients) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
        );
      }
    });

    final categories = [
      {'name': 'All', 'icon': CupertinoIcons.square_grid_2x2},
      {'name': 'Phone', 'icon': CupertinoIcons.device_phone_portrait},
      {'name': 'Watch', 'icon': CupertinoIcons.clock},
      {'name': 'Laptop', 'icon': CupertinoIcons.device_laptop},
      {'name': 'Accessory', 'icon': CupertinoIcons.headphones},
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 900 ? 4 : (screenWidth > 600 ? 3 : 2);

    final bottomPadding =
        49.0 + MediaQuery.of(context).padding.bottom + AppSpacing.md;

    return AppScaffold(
      safeAreaTop: true,
      safeAreaBottom: false,
      appBar: null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.body(
                      'Good Morning,',
                      color: colors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 2),
                    AppText.title2(
                      'John Appleseed',
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildHeaderCircleButton(
                      context,
                      icon: CupertinoIcons.bell,
                      onPressed: () {
                        AppDialog.showAlert(
                          context: context,
                          title: 'Notifications',
                          message: 'You have no new promotional alerts.',
                        );
                      },
                      badge: Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF3B30),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),

                    _buildHeaderCircleButton(
                      context,
                      icon: CupertinoIcons.bag,
                      onPressed: () {
                        AppDialog.showAlert(
                          context: context,
                          title: 'Cart Bag',
                          message: 'You have 2 items in your shopping cart.',
                        );
                      },
                      badge: Positioned(
                        top: 2,
                        right: 2,
                        child: Container(
                          padding: const EdgeInsets.all(3.0),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF3B30),
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 14,
                            minHeight: 14,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '2',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                SliverPersistentHeader(
                  floating: true,
                  delegate: _SearchHeaderDelegate(
                    height: 56.0,
                    backgroundColor: colors.background,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppSearchField(
                              hintText: 'Search product, category...',
                              onChanged: (val) =>
                                  shopNotifier.setSearchQuery(val),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),

                          GestureDetector(
                            onTap: () {
                              AppDialog.showAlert(
                                context: context,
                                title: 'Filters',
                                message:
                                    'Advanced filters and sorting parameters.',
                              );
                            },
                            child: Container(
                              width: 44.0,
                              height: 44.0,
                              decoration: BoxDecoration(
                                color: colors.border.withValues(alpha: 0.15),
                                borderRadius: AppRadius.borderMd,
                              ),
                              alignment: Alignment.center,
                              child: AppIcon(
                                CupertinoIcons.slider_horizontal_3,
                                color: colors.textPrimary,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24.0),
                      child: Container(
                        height: 185.0,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFE2E2FF), Color(0xFFF3F3FF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Padding(
                                padding: const EdgeInsets.all(AppSpacing.lg),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFFFFFFFF,
                                        ).withValues(alpha: 0.6),
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                      ),
                                      child: const AppText.caption(
                                        'New Collection',
                                        color: Color(0xFF5C5CFF),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText.title2(
                                          'iPhone 15 Pro',
                                          color: colors.textPrimary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        const SizedBox(height: 4),
                                        AppText.caption(
                                          'Titanium. So strong. So light. So Pro.',
                                          color: colors.textSecondary,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),

                                    AppPrimaryButton(
                                      text: 'Shop Now',
                                      fullWidth: false,
                                      height: 36.0,
                                      onPressed: () {
                                        final iphone = shopState.products.value
                                            ?.firstWhere(
                                              (p) => p.id == '1',
                                              orElse: () =>
                                                  _mockIphoneFallback(),
                                            );
                                        if (iphone != null) {
                                          context.goNamed(
                                            RouteConfig.detailsName,
                                            extra: iphone,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(AppSpacing.sm),
                                child: AppNetworkImage(
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=600&auto=format&fit=crop&q=60',
                                  fit: BoxFit.contain,
                                  borderRadius: BorderRadius.circular(
                                    AppSpacing.md,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 90.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        final name = cat['name'] as String;
                        final icon = cat['icon'] as IconData;
                        final isSelected = name == shopState.selectedCategory;

                        return Padding(
                          padding: const EdgeInsets.only(right: AppSpacing.sm),
                          child: GestureDetector(
                            onTap: () => shopNotifier.setCategory(name),
                            child: Container(
                              width: 72.0,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? colors.primary.withValues(alpha: 0.08)
                                    : colors.surface,
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                  color: isSelected
                                      ? colors.primary
                                      : colors.border.withValues(alpha: 0.15),
                                  width: isSelected ? 1.0 : 0.5,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppIcon(
                                    icon,
                                    color: isSelected
                                        ? colors.primary
                                        : colors.textSecondary,
                                    size: 24,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  AppText.footnote(
                                    name,
                                    color: isSelected
                                        ? colors.primary
                                        : colors.textSecondary,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.lg,
                      AppSpacing.md,
                      AppSpacing.sm,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.title2(
                          'Flash Sale',
                          fontWeight: FontWeight.bold,
                        ),
                        GestureDetector(
                          onTap: () {
                            AppDialog.showAlert(
                              context: context,
                              title: 'Flash Sale',
                              message:
                                  'Explore all ongoing limited-time offers.',
                            );
                          },
                          child: Row(
                            children: [
                              AppText.footnote(
                                'See All',
                                color: colors.textSecondary,
                              ),
                              const SizedBox(width: 2),
                              AppIcon(
                                CupertinoIcons.chevron_right,
                                size: 10,
                                color: colors.textSecondary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 192.0,
                    child: shopState.products.when(
                      loading: () => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                        ),
                        itemCount: 3,
                        itemBuilder: (context, idx) => Skeletonizer(
                          enabled: true,
                          child: Container(
                            width: 155.0,
                            margin: const EdgeInsets.only(right: AppSpacing.md),
                            decoration: BoxDecoration(
                              color: colors.surface,
                              borderRadius: AppRadius.borderMd,
                            ),
                          ),
                        ),
                      ),
                      error: (err, st) => Container(),
                      data: (productList) {
                        final flashSaleList = productList
                            .where((p) => p.isOnFlashSale)
                            .toList();
                        if (flashSaleList.isEmpty) {
                          return const Center(
                            child: AppText.body('No flash sales today.'),
                          );
                        }

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                          ),
                          itemCount: flashSaleList.length,
                          itemBuilder: (context, idx) {
                            final product = flashSaleList[idx];

                            return Container(
                              width: 155.0,
                              margin: const EdgeInsets.only(
                                right: AppSpacing.md,
                              ),
                              child: Stack(
                                children: [
                                  AppCard(
                                    onTap: () {
                                      context.goNamed(
                                        RouteConfig.detailsName,
                                        extra: product,
                                      );
                                    },
                                    padding: EdgeInsets.zero,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppNetworkImage(
                                          imageUrl: product.imageUrl,
                                          height: 110.0,
                                          width: double.infinity,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(18.0),
                                            topRight: Radius.circular(18.0),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: AppSpacing.sm,
                                            vertical: 6.0,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppText.caption(
                                                product.name,
                                                color: colors.textPrimary,
                                                fontWeight: FontWeight.bold,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 2),
                                              Row(
                                                children: [
                                                  AppText.caption(
                                                    '\$${product.price.toStringAsFixed(0)}',
                                                    color: colors.textPrimary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  if (product.originalPrice !=
                                                      null)
                                                    Text(
                                                      '\$${product.originalPrice!.toStringAsFixed(0)}',
                                                      style: TextStyle(
                                                        color:
                                                            colors.textTertiary,
                                                        fontSize: 10,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const Positioned(
                                    left: 8,
                                    top: 8,
                                    child: FlashSaleTimer(),
                                  ),
                                  if (product.discountPercentage != null)
                                    Positioned(
                                      right: 8,
                                      top: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: colors.primary,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: AppText(
                                          '-${product.discountPercentage}%',
                                          variant: AppTextVariant.caption,
                                          color: const Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.lg,
                      AppSpacing.md,
                      AppSpacing.sm,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.title2(
                          'Recommended For You',
                          fontWeight: FontWeight.bold,
                        ),
                        GestureDetector(
                          onTap: () {
                            AppDialog.showAlert(
                              context: context,
                              title: 'Recommended',
                              message: 'Explore list of personalized products.',
                            );
                          },
                          child: Row(
                            children: [
                              AppText.footnote(
                                'See All',
                                color: colors.textSecondary,
                              ),
                              const SizedBox(width: 2),
                              AppIcon(
                                CupertinoIcons.chevron_right,
                                size: 10,
                                color: colors.textSecondary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                shopState.products.when(
                  loading: () => SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: AppSpacing.md,
                        mainAxisSpacing: AppSpacing.md,
                        childAspectRatio: 0.76,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Skeletonizer(
                          enabled: true,
                          child: Container(
                            decoration: BoxDecoration(
                              color: colors.surface,
                              borderRadius: AppRadius.borderMd,
                            ),
                          ),
                        ),
                        childCount: 4,
                      ),
                    ),
                  ),
                  error: (err, st) => SliverFillRemaining(
                    child: Center(child: Text(err.toString())),
                  ),
                  data: (productList) {
                    final recommendedList = productList
                        .where((p) => !p.isOnFlashSale)
                        .toList();
                    if (recommendedList.isEmpty) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: AppEmptyState(
                          title: 'No Recommendations',
                          description:
                              'Try adjusting filters to find other items.',
                        ),
                      );
                    }

                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: AppSpacing.md,
                          mainAxisSpacing: AppSpacing.md,
                          childAspectRatio: 0.78,
                        ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final product = recommendedList[index];

                          return Stack(
                            children: [
                              AppCard(
                                onTap: () {
                                  context.goNamed(
                                    RouteConfig.detailsName,
                                    extra: product,
                                  );
                                },
                                padding: EdgeInsets.zero,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppNetworkImage(
                                      imageUrl: product.imageUrl,
                                      height: 120.0,
                                      width: double.infinity,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(18.0),
                                        topRight: Radius.circular(18.0),
                                      ),
                                    ),

                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                          AppSpacing.sm,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppText.caption(
                                                  product.category
                                                      .toUpperCase(),
                                                  color: colors.textSecondary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                const SizedBox(height: 2),
                                                AppText.subheadline(
                                                  product.name,
                                                  color: colors.textPrimary,
                                                  fontWeight: FontWeight.bold,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AppText.body(
                                                  '\$${product.price.toStringAsFixed(0)}',
                                                  color: colors.primary,
                                                  fontWeight: FontWeight.bold,
                                                ),

                                                GestureDetector(
                                                  onTap: () {
                                                    AppBottomSheet.show(
                                                      context: context,
                                                      builder: (sheetContext) => Padding(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              vertical:
                                                                  AppSpacing.md,
                                                            ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            AppIcon(
                                                              CupertinoIcons
                                                                  .checkmark_circle,
                                                              size: 48,
                                                              color: colors
                                                                  .success,
                                                            ),
                                                            AppSpacing.gapMd,
                                                            AppText.title2(
                                                              'Added to Bag',
                                                            ),
                                                            AppSpacing.gapSm,
                                                            AppText.body(
                                                              '${product.name} is added to your shopping bag.',
                                                            ),
                                                            AppSpacing.gapLg,
                                                            AppPrimaryButton(
                                                              text: 'OK',
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                    sheetContext,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          4.0,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: colors.primary
                                                          .withValues(
                                                            alpha: 0.1,
                                                          ),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: AppIcon(
                                                      CupertinoIcons.plus,
                                                      size: 14,
                                                      color: colors.primary,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Positioned(
                                right: AppSpacing.sm,
                                top: AppSpacing.sm,
                                child: GestureDetector(
                                  onTap: () {
                                    shopNotifier.toggleWishlist(product.id);
                                  },
                                  child: Container(
                                    width: 32.0,
                                    height: 32.0,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFFFFF),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(
                                            0x00000000,
                                          ).withValues(alpha: 0.1),
                                          blurRadius: 6.0,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    child: AppIcon(
                                      product.isWishlisted
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      size: 16,
                                      color: product.isWishlisted
                                          ? const Color(0xFFFF3B30)
                                          : const Color(0xFF8E8E93),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }, childCount: recommendedList.length),
                      ),
                    );
                  },
                ),

                SliverToBoxAdapter(child: SizedBox(height: bottomPadding)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCircleButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
    required Widget badge,
  }) {
    final colors = AppColors.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 42.0,
            height: 42.0,
            decoration: BoxDecoration(
              color: colors.border.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: AppIcon(icon, color: colors.textPrimary, size: 20),
          ),
          badge,
        ],
      ),
    );
  }

  Product _mockIphoneFallback() {
    return const Product(
      id: '1',
      name: 'iPhone 15 Pro',
      price: 999.0,
      originalPrice: 1199.0,
      discountPercentage: 17,
      imageUrl:
          'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=600&auto=format&fit=crop&q=60',
      description:
          'Titanium design, A17 Pro chip, action button, and the most powerful iPhone camera system ever.',
      category: 'Phone',
      isOnFlashSale: true,
    );
  }
}

class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;
  final Color backgroundColor;

  _SearchHeaderDelegate({
    required this.child,
    required this.height,
    required this.backgroundColor,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: backgroundColor,
      alignment: Alignment.center,
      height: height,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _SearchHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.height != height ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
