import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/catalog/data/demo_catalog_repository.dart';
import '../features/order/application/order_draft.dart';
import '../features/shell/presentation/root_shell.dart';

class OneTapApp extends StatefulWidget {
  const OneTapApp({super.key});

  @override
  State<OneTapApp> createState() => _OneTapAppState();
}

class _OneTapAppState extends State<OneTapApp> {
  late final DemoCatalogRepository _catalog;
  late final OrderDraft _orderDraft;

  @override
  void initState() {
    super.initState();
    _catalog = const DemoCatalogRepository();
    _orderDraft = OrderDraft();
  }

  @override
  void dispose() {
    _orderDraft.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OneTap.kz',
      theme: AppTheme.light,
      home: RootShell(catalog: _catalog, orderDraft: _orderDraft),
    );
  }
}
