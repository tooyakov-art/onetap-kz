import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/delivery_dates.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../order/application/order_draft.dart';
import '../../domain/catalog_models.dart';
import '../widgets/brand_logo.dart';
import 'catalog_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.catalog,
    required this.orderDraft,
    required this.onOpenCart,
  });

  final CatalogRepository catalog;
  final OrderDraft orderDraft;
  final VoidCallback onOpenCart;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _category = 'Все';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visibleSuppliers = _category == 'Все'
        ? widget.catalog.suppliers
        : widget.catalog.suppliers
              .where((supplier) => supplier.category == _category)
              .toList(growable: false);

    return Scaffold(
      appBar: AppBar(
        title: const _BrandTitle(),
        actions: [
          AnimatedBuilder(
            animation: widget.orderDraft,
            builder: (context, child) => Badge(
              isLabelVisible: widget.orderDraft.itemCount > 0,
              label: Text('${widget.orderDraft.itemCount}'),
              child: IconButton(
                key: const ValueKey('open-cart'),
                onPressed: widget.onOpenCart,
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.xs,
          AppSpacing.md,
          AppSpacing.xxl,
        ),
        children: [
          const _VenueCard(),
          const SizedBox(height: AppSpacing.xl),
          Text('Что заказываем?', style: theme.textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.sm),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['Все', 'Алкоголь', 'Напитки']
                  .map(
                    (category) => Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.xs),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: _category == category,
                        onSelected: (_) => setState(() => _category = category),
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.sm,
              mainAxisSpacing: AppSpacing.sm,
              childAspectRatio: AppSizes.cardAspectRatio,
            ),
            itemCount: visibleSuppliers.length,
            itemBuilder: (context, index) {
              final supplier = visibleSuppliers[index];
              return _SupplierCard(
                supplier: supplier,
                itemCount: widget.orderDraft
                    .groupedLines(widget.catalog)[supplier]
                    ?.fold<int>(0, (total, line) => total + line.quantity),
                onTap: () => Navigator.of(context).push(
                  CupertinoPageRoute<void>(
                    builder: (_) => CatalogPage(
                      catalog: widget.catalog,
                      supplier: supplier,
                      orderDraft: widget.orderDraft,
                      onOpenCart: widget.onOpenCart,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BrandTitle extends StatelessWidget {
  const _BrandTitle();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('OneTap.kz', style: theme.textTheme.titleLarge),
        Text('для баров и ресторанов', style: theme.textTheme.bodySmall),
      ],
    );
  }
}

class _VenueCard extends StatelessWidget {
  const _VenueCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nextDelivery = formatDeliveryDate(
      upcomingDeliveryDates(DateTime.now(), count: 1).single,
    );
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
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.gold,
                  size: AppSizes.iconSmall,
                ),
                const SizedBox(width: AppSpacing.xxs),
                Text(
                  'ASTANA · BAR № 1',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppColors.whiteMuted,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Один заказ.\nВсе поставщики.',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: AppColors.surface,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                const Icon(
                  Icons.local_shipping_outlined,
                  color: AppColors.whiteSubtle,
                  size: AppSizes.iconSmall,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'Ближайшая доставка · $nextDelivery',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.whiteSubtle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SupplierCard extends StatelessWidget {
  const _SupplierCard({
    required this.supplier,
    required this.onTap,
    this.itemCount,
  });

  final Supplier supplier;
  final VoidCallback onTap;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppRadii.lg)),
      ),
      child: InkWell(
        key: ValueKey('supplier-${supplier.id}'),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppSizes.supplierLogoBox,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: BrandLogo(brand: supplier.brand),
                ),
              ),
              const Spacer(),
              Text(supplier.name, style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.xxs),
              Text(supplier.caption, style: theme.textTheme.bodySmall),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      itemCount == null || itemCount == 0
                          ? supplier.deliveryLabel
                          : '$itemCount шт. в корзине',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: itemCount == null || itemCount == 0
                            ? AppColors.inkMuted
                            : AppColors.green,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: AppSizes.iconSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
