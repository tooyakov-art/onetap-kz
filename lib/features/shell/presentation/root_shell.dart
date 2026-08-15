import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/formatters.dart';
import '../../../core/theme/app_tokens.dart';
import '../../catalog/domain/catalog_models.dart';
import '../../catalog/presentation/pages/home_page.dart';
import '../../order/application/order_draft.dart';
import '../../order/presentation/pages/cart_page.dart';

class RootShell extends StatefulWidget {
  const RootShell({super.key, required this.catalog, required this.orderDraft});

  final CatalogRepository catalog;
  final OrderDraft orderDraft;

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(
            catalog: widget.catalog,
            orderDraft: widget.orderDraft,
            onOpenCart: _openCart,
          ),
          const OrdersPage(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view_rounded),
            label: 'Каталог',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long_rounded),
            label: 'Заказы',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }

  void _openCart() {
    Navigator.of(context).push(
      CupertinoPageRoute<void>(
        builder: (_) =>
            CartPage(catalog: widget.catalog, orderDraft: widget.orderDraft),
      ),
    );
  }
}

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Мои заказы')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text('Сегодня', style: theme.textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.md),
          const _OrderStatusCard(
            supplier: 'Kazakhstan W&S',
            status: 'Принят компанией',
            details: '3 позиции · доставка 20 августа',
            total: 40100,
            color: AppColors.green,
            background: AppColors.greenSoft,
          ),
          const SizedBox(height: AppSpacing.sm),
          const _OrderStatusCard(
            supplier: 'Coca-Cola',
            status: 'Проверяют наличие',
            details: '2 позиции · доставка 20 августа',
            total: 1100,
            color: AppColors.gold,
            background: AppColors.goldSoft,
          ),
          const SizedBox(height: AppSpacing.sm),
          const _OrderStatusCard(
            supplier: 'PepsiCo',
            status: 'Заявка отправлена',
            details: '1 позиция · доставка 21 августа',
            total: 620,
            color: AppColors.blue,
            background: AppColors.blueSoft,
          ),
          const SizedBox(height: AppSpacing.xl),
          DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.all(Radius.circular(AppRadii.md)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.inkMuted,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Оплаты внутри приложения нет. Счёт появится здесь или придёт через WhatsApp.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderStatusCard extends StatelessWidget {
  const _OrderStatusCard({
    required this.supplier,
    required this.status,
    required this.details,
    required this.total,
    required this.color,
    required this.background,
  });

  final String supplier;
  final String status;
  final String details;
  final int total;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                  child: Text(supplier, style: theme.textTheme.titleLarge),
                ),
                Text(formatMoney(total), style: theme.textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            DecoratedBox(
              decoration: BoxDecoration(
                color: background,
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppRadii.pill),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                child: Text(
                  status,
                  style: theme.textTheme.labelMedium?.copyWith(color: color),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(details, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          const CircleAvatar(
            radius: AppSpacing.xxl,
            backgroundColor: AppColors.ink,
            foregroundColor: AppColors.surface,
            child: Text('ДТ'),
          ),
          const SizedBox(height: AppSpacing.md),
          Center(child: Text('Диас Туяков', style: theme.textTheme.titleLarge)),
          const SizedBox(height: AppSpacing.xxs),
          Center(
            child: Text('Бармен · Bar № 1', style: theme.textTheme.bodyMedium),
          ),
          const SizedBox(height: AppSpacing.xxl),
          const _ProfileTile(
            icon: Icons.storefront_outlined,
            title: 'Заведение',
            subtitle: 'Bar № 1 · Астана',
          ),
          const SizedBox(height: AppSpacing.sm),
          const _ProfileTile(
            icon: Icons.notifications_none_rounded,
            title: 'Уведомления',
            subtitle: 'Статусы заказов включены',
          ),
          const SizedBox(height: AppSpacing.sm),
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppRadii.md)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(AppSpacing.md),
              leading: const Icon(Icons.local_shipping_outlined),
              title: const Text('Режим поставщика'),
              subtitle: const Text('Посмотреть входящие заявки'),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: AppSizes.iconSmall,
              ),
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute<void>(
                  builder: (_) => const SupplierInboxPage(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppRadii.md)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppSpacing.md),
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}

class SupplierInboxPage extends StatelessWidget {
  const SupplierInboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Входящие заявки')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.ink,
              borderRadius: BorderRadius.all(Radius.circular(AppRadii.lg)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'KAZAKHSTAN W&S',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: AppColors.gold,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    '3 новые заявки',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.surface,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('Сегодня', style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          const _IncomingRequest(
            venue: 'Bar № 1',
            bartender: 'Диас Туяков',
            details: '4 позиции · на 20 августа',
            total: 65500,
          ),
          const SizedBox(height: AppSpacing.sm),
          const _IncomingRequest(
            venue: 'SREDA',
            bartender: 'Алексей',
            details: '7 позиций · на 21 августа',
            total: 124000,
          ),
        ],
      ),
    );
  }
}

class _IncomingRequest extends StatelessWidget {
  const _IncomingRequest({
    required this.venue,
    required this.bartender,
    required this.details,
    required this.total,
  });

  final String venue;
  final String bartender;
  final String details;
  final int total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                Expanded(child: Text(venue, style: theme.textTheme.titleLarge)),
                Text(formatMoney(total), style: theme.textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text('$bartender · $details', style: theme.textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.md),
            FilledButton.tonal(
              onPressed: () {},
              child: const Text('Открыть заявку'),
            ),
          ],
        ),
      ),
    );
  }
}
