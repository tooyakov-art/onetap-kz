import 'package:flutter/material.dart';

import '../../../../core/formatters.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../order/application/order_draft.dart';
import '../../domain/catalog_models.dart';
import '../widgets/brand_logo.dart';
import '../widgets/product_tile.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({
    super.key,
    required this.catalog,
    required this.supplier,
    required this.orderDraft,
    required this.onOpenCart,
  });

  final CatalogRepository catalog;
  final Supplier supplier;
  final OrderDraft orderDraft;
  final VoidCallback onOpenCart;

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  CatalogSection? _selectedSection;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final products = widget.catalog.productsFor(widget.supplier.id);
    final sections = products
        .map((product) => product.section)
        .toSet()
        .toList();
    final visibleProducts = _selectedSection == null
        ? products
        : products
              .where((product) => product.section == _selectedSection)
              .toList(growable: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.supplier.name),
        actions: [
          AnimatedBuilder(
            animation: widget.orderDraft,
            builder: (context, child) => Badge(
              isLabelVisible: widget.orderDraft.itemCount > 0,
              label: Text('${widget.orderDraft.itemCount}'),
              child: IconButton(
                key: const ValueKey('catalog-open-cart'),
                onPressed: widget.onOpenCart,
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: AnimatedBuilder(
        animation: widget.orderDraft,
        builder: (context, child) => ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.xs,
            AppSpacing.md,
            AppSpacing.huge,
          ),
          children: [
            _CatalogHeader(supplier: widget.supplier),
            if (sections.length > 1) ...[
              const SizedBox(height: AppSpacing.md),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.xs),
                      child: ChoiceChip(
                        label: const Text('Весь прайс'),
                        selected: _selectedSection == null,
                        onSelected: (_) =>
                            setState(() => _selectedSection = null),
                      ),
                    ),
                    ...sections.map(
                      (section) => Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.xs),
                        child: ChoiceChip(
                          label: Text(_sectionLabel(section)),
                          selected: _selectedSection == section,
                          onSelected: (_) =>
                              setState(() => _selectedSection = section),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: Text('Прайс', style: theme.textTheme.headlineMedium),
                ),
                Text(
                  '${visibleProducts.length} позиций',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ...visibleProducts.map(
              (product) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: ProductTile(
                  key: ValueKey('product-${product.id}'),
                  product: product,
                  orderDraft: widget.orderDraft,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: widget.orderDraft,
        builder: (context, child) {
          if (widget.orderDraft.itemCount == 0) {
            return const SizedBox.shrink();
          }
          return SafeArea(
            minimum: const EdgeInsets.all(AppSpacing.sm),
            child: FilledButton.icon(
              onPressed: widget.onOpenCart,
              icon: const Icon(Icons.shopping_bag_outlined),
              label: Text(
                '${widget.orderDraft.itemCount} шт. · ${formatMoney(widget.orderDraft.total(widget.catalog))}',
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CatalogHeader extends StatelessWidget {
  const _CatalogHeader({required this.supplier});

  final Supplier supplier;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.all(Radius.circular(AppRadii.lg)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BrandLogo(brand: supplier.brand, light: true),
            const SizedBox(height: AppSpacing.xl),
            Text(
              supplier.category.toUpperCase(),
              style: theme.textTheme.labelMedium?.copyWith(
                color: AppColors.gold,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              supplier.caption,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: AppColors.surface,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Объём рядом с ценой · акции выделены красным',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.whiteSubtle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _sectionLabel(CatalogSection section) => switch (section) {
  CatalogSection.spirits => 'Крепкое',
  CatalogSection.wine => 'Вино',
  CatalogSection.softDrinks => 'Напитки',
};
