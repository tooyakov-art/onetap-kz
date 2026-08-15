import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_tokens.dart';
import '../../domain/catalog_models.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, required this.brand, this.light = false});

  final SupplierBrand brand;
  final bool light;

  @override
  Widget build(BuildContext context) {
    return switch (brand) {
      SupplierBrand.kws => SvgPicture.asset(
        'assets/brands/kws.svg',
        height: AppSizes.logoHeight,
        colorFilter: light
            ? const ColorFilter.mode(AppColors.surface, BlendMode.srcIn)
            : null,
      ),
      SupplierBrand.cocaCola => SvgPicture.asset(
        'assets/brands/coca-cola.svg',
        height: AppSizes.logoHeight,
        colorFilter: light
            ? const ColorFilter.mode(AppColors.surface, BlendMode.srcIn)
            : null,
      ),
      SupplierBrand.pepsi => Image.asset(
        'assets/brands/pepsi.png',
        height: AppSizes.logoHeight,
        fit: BoxFit.contain,
      ),
    };
  }
}
