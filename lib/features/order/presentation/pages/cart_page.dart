import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/delivery_dates.dart';
import '../../../../core/formatters.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../catalog/domain/catalog_models.dart';
import '../../application/order_draft.dart';
import 'order_success_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.catalog, required this.orderDraft});

  final CatalogRepository catalog;
  final OrderDraft orderDraft;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final TextEditingController _commentController = TextEditingController();
  late final List<DateTime> _deliveryDates;
  late DateTime _deliveryDate;

  @override
  void initState() {
    super.initState();
    _deliveryDates = upcomingDeliveryDates(DateTime.now());
    _deliveryDate = _deliveryDates.first;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Общий заказ')),
      body: AnimatedBuilder(
        animation: widget.orderDraft,
        builder: (context, child) {
          final grouped = widget.orderDraft.groupedLines(widget.catalog);
          if (grouped.isEmpty) {
            return const _EmptyCart();
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.xs,
              AppSpacing.md,
              AppSpacing.huge,
            ),
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  color: AppColors.goldSoft,
                  borderRadius: BorderRadius.all(Radius.circular(AppRadii.md)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.call_split_rounded,
                        color: AppColors.gold,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          'OneTap сам разделит заказ на ${grouped.length} заявки поставщикам.',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              ...grouped.entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: _SupplierOrderCard(
                    supplier: entry.key,
                    lines: entry.value,
                    orderDraft: widget.orderDraft,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text('Дата доставки', style: theme.textTheme.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _deliveryDates
                      .map(
                        (date) => Padding(
                          padding: const EdgeInsets.only(right: AppSpacing.xs),
                          child: ChoiceChip(
                            label: Text(formatDeliveryDate(date)),
                            selected: _deliveryDate == date,
                            onSelected: (_) =>
                                setState(() => _deliveryDate = date),
                          ),
                        ),
                      )
                      .toList(growable: false),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text('Комментарий', style: theme.textTheme.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _commentController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Например: принять товар после 15:00',
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: [
                  Expanded(
                    child: Text('Итого', style: theme.textTheme.titleLarge),
                  ),
                  Text(
                    formatMoney(widget.orderDraft.total(widget.catalog)),
                    style: theme.textTheme.headlineMedium,
                  ),
                ],
              ),
            ],
          );
        },
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
              key: const ValueKey('send-to-all'),
              onPressed: _submit,
              icon: const Icon(Icons.send_rounded),
              label: Text(
                'Сформировать заказ · ${formatMoney(widget.orderDraft.total(widget.catalog))}',
              ),
            ),
          );
        },
      ),
    );
  }

  void _submit() {
    final grouped = widget.orderDraft.groupedLines(widget.catalog);
    final supplierCount = grouped.length;
    final itemCount = widget.orderDraft.itemCount;
    final total = widget.orderDraft.total(widget.catalog);
    final orderText = _formatOrder(grouped, total);
    widget.orderDraft.clear();
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute<void>(
        builder: (_) => OrderSuccessPage(
          supplierCount: supplierCount,
          itemCount: itemCount,
          total: total,
          deliveryDate: formatDeliveryDate(_deliveryDate),
          orderText: orderText,
        ),
      ),
    );
  }

  String _formatOrder(Map<Supplier, List<OrderLine>> grouped, int total) {
    final buffer = StringBuffer()
      ..writeln('Заказ OneTap.kz')
      ..writeln('Доставка: ${formatDeliveryDate(_deliveryDate)}');

    final comment = _commentController.text.trim();
    if (comment.isNotEmpty) {
      buffer.writeln('Комментарий: $comment');
    }

    for (final entry in grouped.entries) {
      buffer
        ..writeln()
        ..writeln(entry.key.name);
      for (final line in entry.value) {
        buffer.writeln(
          '${line.product.name} · ${line.product.volume} · '
          '${line.quantity} шт. · ${formatMoney(line.total)}',
        );
      }
    }

    buffer
      ..writeln()
      ..write('Итого: ${formatMoney(total)}');
    return buffer.toString();
  }
}

class _SupplierOrderCard extends StatelessWidget {
  const _SupplierOrderCard({
    required this.supplier,
    required this.lines,
    required this.orderDraft,
  });

  final Supplier supplier;
  final List<OrderLine> lines;
  final OrderDraft orderDraft;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = lines.fold(0, (value, line) => value + line.total);
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppRadii.md)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(supplier.name, style: theme.textTheme.titleLarge),
                ),
                Text(formatMoney(total), style: theme.textTheme.titleMedium),
              ],
            ),
            const Divider(),
            ...lines.map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            line.product.name,
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            '${line.product.volume} · ${formatMoney(line.product.price)}',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => orderDraft.remove(line.product),
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.sm,
                      ),
                      child: Text(
                        '${line.quantity}',
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                    IconButton(
                      onPressed: () => orderDraft.add(line.product),
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.shopping_bag_outlined,
              size: AppSpacing.huge,
              color: AppColors.inkMuted,
            ),
            const SizedBox(height: AppSpacing.md),
            Text('Корзина пока пустая', style: theme.textTheme.titleLarge),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Добавьте товары у одного или нескольких поставщиков.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
