import 'package:flutter/material.dart';

import '../../../../core/formatters.dart';
import '../../../../core/theme/app_tokens.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({
    super.key,
    required this.supplierCount,
    required this.itemCount,
    required this.total,
    required this.deliveryDate,
  });

  final int supplierCount;
  final int itemCount;
  final int total;
  final String deliveryDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.greenSoft,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Icon(
                    Icons.check_rounded,
                    color: AppColors.green,
                    size: AppSizes.iconLarge,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text('Заказ отправлен', style: theme.textTheme.headlineLarge),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Один клик создал $supplierCount отдельные заявки. Каждая компания получила только свои товары.',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSpacing.xxl),
              _SummaryRow(label: 'Товаров', value: '$itemCount шт.'),
              _SummaryRow(label: 'Доставка', value: deliveryDate),
              _SummaryRow(label: 'Общая сумма', value: formatMoney(total)),
              const Spacer(),
              FilledButton(
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text('Вернуться на главную'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          Expanded(child: Text(label, style: theme.textTheme.bodyLarge)),
          Text(value, style: theme.textTheme.titleMedium),
        ],
      ),
    );
  }
}
