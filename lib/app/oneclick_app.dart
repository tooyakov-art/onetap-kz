import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/catalog/data/demo_catalog_repository.dart';
import '../features/order/application/order_draft.dart';
import '../features/shell/presentation/root_shell.dart';

class OneClickApp extends StatefulWidget {
  const OneClickApp({super.key});

  @override
  State<OneClickApp> createState() => _OneClickAppState();
}

class _OneClickAppState extends State<OneClickApp> {
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
      title: 'OneClick.kz',
      theme: AppTheme.light,
      home: RootShell(catalog: _catalog, orderDraft: _orderDraft),
    );
  }
}
