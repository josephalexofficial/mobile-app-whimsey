import 'package:flutter/material.dart';

/// Brand colors shared by the light and dark Whimsey themes.
@immutable
class WhimseyColors extends ThemeExtension<WhimseyColors> {
  const WhimseyColors({
    required this.canvas,
    required this.canvasMuted,
    required this.surface,
    required this.text,
    required this.subhead,
    required this.caption,
    required this.border,
    required this.accentSoft,
    required this.header,
    required this.inputFill,
  });

  final Color canvas;
  final Color canvasMuted;
  final Color surface;
  final Color text;
  final Color subhead;
  final Color caption;
  final Color border;
  final Color accentSoft;
  final Color header;
  final Color inputFill;

  static const Color accent = Color(0xFF0056D2);
  static const Color accentPressed = Color(0xFF0047B3);
  static const Color danger = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  static const WhimseyColors light = WhimseyColors(
    canvas: Color(0xFFFFFFFF),
    canvasMuted: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    text: Color(0xFF0F172A),
    subhead: Color(0xFF334155),
    caption: Color(0xFF475569),
    border: Color(0x1A0F172A),
    accentSoft: Color(0x0D0056D2),
    header: Color(0xF2FFFFFF),
    inputFill: Color(0xFFF8FAFC),
  );

  static const WhimseyColors dark = WhimseyColors(
    canvas: Color(0xFF0B0F19),
    canvasMuted: Color(0xFF080B14),
    surface: Color(0xFF0B0F19),
    text: Color(0xFFFFFFFF),
    subhead: Color(0xFFCBD5E1),
    caption: Color(0xFF94A3B8),
    border: Color(0x1AFFFFFF),
    accentSoft: Color(0x1F0056D2),
    header: Color(0xF20B0F19),
    inputFill: Color(0xFF080B14),
  );

  @override
  WhimseyColors copyWith({
    Color? canvas,
    Color? canvasMuted,
    Color? surface,
    Color? text,
    Color? subhead,
    Color? caption,
    Color? border,
    Color? accentSoft,
    Color? header,
    Color? inputFill,
  }) {
    return WhimseyColors(
      canvas: canvas ?? this.canvas,
      canvasMuted: canvasMuted ?? this.canvasMuted,
      surface: surface ?? this.surface,
      text: text ?? this.text,
      subhead: subhead ?? this.subhead,
      caption: caption ?? this.caption,
      border: border ?? this.border,
      accentSoft: accentSoft ?? this.accentSoft,
      header: header ?? this.header,
      inputFill: inputFill ?? this.inputFill,
    );
  }

  @override
  WhimseyColors lerp(ThemeExtension<WhimseyColors>? other, double t) {
    if (other is! WhimseyColors) {
      return this;
    }

    return WhimseyColors(
      canvas: Color.lerp(canvas, other.canvas, t) ?? canvas,
      canvasMuted: Color.lerp(canvasMuted, other.canvasMuted, t) ?? canvasMuted,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      text: Color.lerp(text, other.text, t) ?? text,
      subhead: Color.lerp(subhead, other.subhead, t) ?? subhead,
      caption: Color.lerp(caption, other.caption, t) ?? caption,
      border: Color.lerp(border, other.border, t) ?? border,
      accentSoft: Color.lerp(accentSoft, other.accentSoft, t) ?? accentSoft,
      header: Color.lerp(header, other.header, t) ?? header,
      inputFill: Color.lerp(inputFill, other.inputFill, t) ?? inputFill,
    );
  }
}

/// Returns the active Whimsey palette. Throws if the theme was built without it.
WhimseyColors whimseyColorsOf(BuildContext context) {
  final colors = Theme.of(context).extension<WhimseyColors>();
  if (colors == null) {
    throw StateError('WhimseyColors is missing from the active theme.');
  }
  return colors;
}
