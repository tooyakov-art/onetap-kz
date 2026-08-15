import 'package:flutter/material.dart';

import 'app_tokens.dart';

abstract final class AppTheme {
  static ThemeData get light {
    const scheme = ColorScheme.light(
      primary: AppColors.ink,
      onPrimary: AppColors.surface,
      secondary: AppColors.gold,
      onSecondary: AppColors.ink,
      surface: AppColors.surface,
      onSurface: AppColors.ink,
      error: AppColors.red,
      onError: AppColors.surface,
      outline: AppColors.line,
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.canvas,
      splashFactory: InkSparkle.splashFactory,
    );

    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        headlineLarge: base.textTheme.headlineLarge?.copyWith(
          color: AppColors.ink,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.1,
        ),
        headlineMedium: base.textTheme.headlineMedium?.copyWith(
          color: AppColors.ink,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
        ),
        titleLarge: base.textTheme.titleLarge?.copyWith(
          color: AppColors.ink,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
        ),
        titleMedium: base.textTheme.titleMedium?.copyWith(
          color: AppColors.ink,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: base.textTheme.bodyLarge?.copyWith(
          color: AppColors.ink,
          height: 1.35,
        ),
        bodyMedium: base.textTheme.bodyMedium?.copyWith(
          color: AppColors.inkMuted,
          height: 1.35,
        ),
        labelLarge: base.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.canvas,
        foregroundColor: AppColors.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.line,
        thickness: AppSizes.divider,
        space: AppSpacing.xl,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(AppSizes.touch),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          shape: const StadiumBorder(),
          textStyle: base.textTheme.labelLarge,
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        shape: const StadiumBorder(side: BorderSide(color: AppColors.line)),
        side: const BorderSide(color: AppColors.line),
        selectedColor: AppColors.ink,
        labelStyle: base.textTheme.labelLarge,
        secondaryLabelStyle: base.textTheme.labelLarge?.copyWith(
          color: AppColors.surface,
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.goldSoft,
        height: AppSizes.bottomBarHeight,
        labelTextStyle: WidgetStatePropertyAll(base.textTheme.labelSmall),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.md)),
          borderSide: BorderSide(color: AppColors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.md)),
          borderSide: BorderSide(color: AppColors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.md)),
          borderSide: BorderSide(color: AppColors.ink),
        ),
        contentPadding: EdgeInsets.all(AppSpacing.md),
      ),
    );
  }
}
