import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract final class SelidaColors {
  static const Color ink = Color(0xff1d251f);
  static const Color warmPaper = Color(0xfff3ecde);
  static const Color surface = Color(0xfffffaf0);
  static const Color forest = Color(0xff294536);
  static const Color sage = Color(0xff466653);
  static const Color mutedSage = Color(0xffd8e2d6);
  static const Color terracotta = Color(0xffbd664a);
  static const Color mutedTerracotta = Color(0xfff1d8ca);
  static const Color line = Color(0xffd8cebd);
  static const Color error = Color(0xffa94c43);
}

abstract final class SelidaTheme {
  static ThemeData get light {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: SelidaColors.forest,
      onPrimary: Color(0xfffffff8),
      secondary: SelidaColors.terracotta,
      onSecondary: Color(0xfffffff8),
      error: SelidaColors.error,
      onError: Colors.white,
      surface: SelidaColors.surface,
      onSurface: SelidaColors.ink,
    );
    final baseTextTheme = ThemeData.light().textTheme.apply(
      fontFamily: 'Inter',
      bodyColor: SelidaColors.ink,
      displayColor: SelidaColors.ink,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: SelidaColors.warmPaper,
      fontFamily: 'Inter',
      textTheme: baseTextTheme.copyWith(
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(
          fontFamily: 'Literata',
          fontSize: 33,
          fontWeight: FontWeight.w600,
          letterSpacing: -1.1,
          height: 1.1,
        ),
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          fontFamily: 'Literata',
          fontSize: 21,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.45,
        ),
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(height: 1.45),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(height: 1.4),
      ),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      dividerColor: SelidaColors.line,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: SelidaColors.ink,
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 74,
        titleSpacing: 20,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      cardTheme: const CardThemeData(
        color: SelidaColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(22)),
          side: BorderSide(color: SelidaColors.line),
        ),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: SelidaColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: SelidaColors.surface,
        modalBackgroundColor: SelidaColors.surface,
        elevation: 0,
        modalElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        showDragHandle: true,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 68,
        elevation: 0,
        backgroundColor: SelidaColors.surface,
        indicatorColor: SelidaColors.mutedSage,
        labelTextStyle: WidgetStatePropertyAll<TextStyle>(
          baseTextTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(44, 50),
          backgroundColor: SelidaColors.forest,
          foregroundColor: const Color(0xfffffaf0),
          textStyle: baseTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: SelidaColors.forest,
          textStyle: baseTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: SelidaColors.forest,
          side: const BorderSide(color: SelidaColors.line),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: SelidaColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(color: SelidaColors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(color: SelidaColors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: SelidaColors.terracotta,
            width: 1.4,
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: SelidaColors.forest,
        contentTextStyle: TextStyle(color: Color(0xfffffaf0)),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}
