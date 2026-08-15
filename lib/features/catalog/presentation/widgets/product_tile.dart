import 'package:flutter/material.dart';

import '../../../../core/formatters.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../order/application/order_draft.dart';
import '../../domain/catalog_models.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.product,
    required this.orderDraft,
  });

  final Product product;
  final OrderDraft orderDraft;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final quantity = orderDraft.quantityFor(product);

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppRadii.md)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProductBottleArt(product: product),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.gold,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(product.name, style: theme.textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(product.subtitle, style: theme.textTheme.bodySmall),
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: AppSpacing.xs,
                    children: [
                      DecoratedBox(
                        decoration: const BoxDecoration(
                          color: AppColors.surfaceMuted,
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppRadii.pill),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                            vertical: AppSpacing.xxs,
                          ),
                          child: Text(
                            product.volume,
                            style: theme.textTheme.labelMedium,
                          ),
                        ),
                      ),
                      if (product.oldPrice case final oldPrice?)
                        Text(
                          formatMoney(oldPrice),
                          style: theme.textTheme.bodySmall?.copyWith(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Text(
                        formatMoney(product.price),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: product.isPromotion
                              ? AppColors.red
                              : AppColors.ink,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            QuantityStepper(
              quantity: quantity,
              onMinus: () => orderDraft.remove(product),
              onPlus: () => orderDraft.add(product),
            ),
          ],
        ),
      ),
    );
  }
}

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onMinus,
    required this.onPlus,
  });

  final int quantity;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (quantity == 0) {
      return IconButton.filled(
        key: const ValueKey('quantity-add'),
        onPressed: onPlus,
        icon: const Icon(Icons.add_rounded),
      );
    }

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.all(Radius.circular(AppRadii.pill)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            key: const ValueKey('quantity-plus'),
            onPressed: onPlus,
            color: AppColors.surface,
            icon: const Icon(Icons.add_rounded),
          ),
          Text(
            '$quantity',
            style: theme.textTheme.labelLarge?.copyWith(
              color: AppColors.surface,
            ),
          ),
          IconButton(
            key: const ValueKey('quantity-minus'),
            onPressed: onMinus,
            color: AppColors.surface,
            icon: const Icon(Icons.remove_rounded),
          ),
        ],
      ),
    );
  }
}

class ProductBottleArt extends StatelessWidget {
  const ProductBottleArt({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final background = product.section == CatalogSection.softDrinks
        ? AppColors.blueSoft
        : AppColors.goldSoft;
    final foreground = product.section == CatalogSection.softDrinks
        ? AppColors.blue
        : AppColors.ink;

    return SizedBox(
      width: AppSizes.productArtWidth,
      height: AppSizes.productArtHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          borderRadius: const BorderRadius.all(Radius.circular(AppRadii.sm)),
        ),
        child: CustomPaint(
          painter: _BottlePainter(color: foreground),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.lg),
              child: Text(
                product.brand.characters.first,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.surface,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottlePainter extends CustomPainter {
  const _BottlePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final neck = Rect.fromLTWH(
      size.width * 0.40,
      size.height * 0.10,
      size.width * 0.20,
      size.height * 0.22,
    );
    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.25,
        size.height * 0.28,
        size.width * 0.50,
        size.height * 0.62,
      ),
      Radius.circular(size.width * 0.12),
    );
    canvas.drawRect(neck, paint);
    canvas.drawRRect(body, paint);
  }

  @override
  bool shouldRepaint(covariant _BottlePainter oldDelegate) =>
      oldDelegate.color != color;
}
