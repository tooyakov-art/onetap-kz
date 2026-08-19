import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

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
            icon: Icon(Icons.info_outline_rounded),
            selectedIcon: Icon(Icons.info_rounded),
            label: 'О приложении',
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.receipt_long_outlined,
                size: AppSpacing.huge,
                color: AppColors.inkMuted,
              ),
              const SizedBox(height: AppSpacing.md),
              Text('История пока пустая', style: theme.textTheme.titleLarge),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Соберите первый заказ в каталоге и сохраните готовую заявку.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static final _privacyUri = Uri.parse(
    'https://onetap-kz.web.app/privacy.html',
  );
  static final _supportUri = Uri.parse(
    'https://onetap-kz.web.app/support.html',
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('О приложении')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          const CircleAvatar(
            radius: AppSpacing.xxl,
            backgroundColor: AppColors.ink,
            foregroundColor: AppColors.surface,
            child: Icon(Icons.storefront_rounded),
          ),
          const SizedBox(height: AppSpacing.md),
          Center(child: Text('OneTap.kz', style: theme.textTheme.titleLarge)),
          const SizedBox(height: AppSpacing.xxs),
          Center(
            child: Text(
              'OneTap.kz · версия 0.1',
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          const _ProfileTile(
            icon: Icons.shield_outlined,
            title: 'Конфиденциальность',
            subtitle: 'Заказы обрабатываются только на устройстве',
          ),
          const SizedBox(height: AppSpacing.sm),
          _ExternalLinkTile(
            icon: Icons.policy_outlined,
            title: 'Политика конфиденциальности',
            uri: _privacyUri,
          ),
          const SizedBox(height: AppSpacing.sm),
          _ExternalLinkTile(
            icon: Icons.support_agent_rounded,
            title: 'Поддержка',
            uri: _supportUri,
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

class _ExternalLinkTile extends StatelessWidget {
  const _ExternalLinkTile({
    required this.icon,
    required this.title,
    required this.uri,
  });

  final IconData icon;
  final String title;
  final Uri uri;

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
        trailing: const Icon(Icons.open_in_new_rounded),
        onTap: () => _openLink(context),
      ),
    );
  }

  Future<void> _openLink(BuildContext context) async {
    if (await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      return;
    }
    await Clipboard.setData(ClipboardData(text: uri.toString()));
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Ссылка скопирована')));
  }
}
// End of OneTap.kz shell widgets
