import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/formatters.dart';
import '../../../../core/theme/app_tokens.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({
    super.key,
    required this.supplierCount,
    required this.itemCount,
    required this.total,
    required this.deliveryDate,
    required this.orderText,
  });

  final int supplierCount;
  final int itemCount;
  final int total;
  final String deliveryDate;
  final String orderText;

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
              Text('Заказ сформирован', style: theme.textTheme.headlineLarge),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'OneTap подготовил $supplierCount отдельные заявки. Скопируйте заказ и отправьте его поставщикам в рабочий чат.',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSpacing.xxl),
              _SummaryRow(label: 'Товаров', value: '$itemCount шт.'),
              _SummaryRow(label: 'Доставка', value: deliveryDate),
              _SummaryRow(label: 'Общая сумма', value: formatMoney(total)),
              const Spacer(),
              FilledButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: orderText));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Заказ скопирован')),
                  );
                },
                icon: const Icon(Icons.copy_all_rounded),
                label: const Text('Скопировать заказ'),
              ),
              const SizedBox(height: AppSpacing.sm),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.surface,
                  foregroundColor: AppColors.ink,
                ),
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
