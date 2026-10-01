import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'whimsey_colors.dart';

const String whimseyFontFamily = 'Jost';

/// Builds the light or dark theme used by every Whimsey screen.
ThemeData buildWhimseyTheme({required Brightness brightness}) {
  final isDark = brightness == Brightness.dark;
  final colors = isDark ? WhimseyColors.dark : WhimseyColors.light;
  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    fontFamily: whimseyFontFamily,
    scaffoldBackgroundColor: colors.canvas,
    colorScheme: ColorScheme.fromSeed(
      seedColor: WhimseyColors.accent,
      brightness: brightness,
      primary: WhimseyColors.accent,
      surface: colors.surface,
    ),
    extensions: const <ThemeExtension<dynamic>>[],
  );

  return base.copyWith(
    extensions: <ThemeExtension<dynamic>>[colors],
    textTheme: base.textTheme.apply(
      fontFamily: whimseyFontFamily,
      bodyColor: colors.text,
      displayColor: colors.text,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colors.header,
      foregroundColor: colors.text,
      elevation: 0,
      scrolledUnderElevation: 0,
      systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
    ),
  );
}
