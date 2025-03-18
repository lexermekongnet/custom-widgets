import 'package:flutter/material.dart';

/// This is the default orange
const originalColor = Color(0xFFf37221);

/// This is the default orange
Color mekongOrange(bool isLight) {
  if (isLight) return originalColor;
  return const Color(0xFFFFFFFF);
}

/// This is the default orange
Color mekongGray(bool isLight) {
  const originalColor = Color(0xFF707276);
  if (isLight) return originalColor;
  return const Color(0xFFFFFFFF);
}

/// This is the default orange
Color mekongDarkGray() => const Color(0xFF737478);

/// This is the default light blue
Color mekongLightBlue() => const Color(0xFF55caf5);

/// This is the light mode color scheme
const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFf37221),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFFFDBCD),
  onPrimaryContainer: Color(0xFF360F00),
  secondary: Color(0xFF707276),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFCFE5FF),
  onSecondaryContainer: Color(0xFF001D33),
  tertiary: Color(0xFFFFFFFF),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFF97F0FF),
  onTertiaryContainer: Color(0xFF001F24),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  surface: Color(0xFFFFFBFF),
  onSurface: Color(0xFF201A18),
  surfaceContainerHighest: Color(0xFFF5DED8),
  onSurfaceVariant: Color(0xFF53433F),
  outline: Color(0xFF85736E),
  onInverseSurface: Color(0xFFFBEEE9),
  inverseSurface: Color(0xFF362F2D),
  inversePrimary: Color(0xFFFFB5A0),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFA04100),
  outlineVariant: Color(0xFFD7C2B9),
  scrim: Color(0xFF000000),
);

/// This is the dark mode color scheme
const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF7e7f83),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFFFDBCE),
  onPrimaryContainer: Color(0xFF370E00),
  secondary: Color(0xFF404346),
  onSecondary: Color(0XFFFFFFFF),
  secondaryContainer: Color(0xFF5F6063),
  onSecondaryContainer: Color(0xFF001E2E),
  tertiary: Color(0xFF1E1E1E),
  onTertiary: Color(0XFFFFFFFF),
  tertiaryContainer: Color(0xFF6D6E71),
  onTertiaryContainer: Color(0xFF001F24),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFB4AB),
  surface: Color(0xFF69686d),
  onSurface: Color(0xFFEDE0DC),
  surfaceContainerHighest: Color(0xFF5B5B5D),
  onSurfaceVariant: Color(0xFF7A7B7D),
  outline: Color(0xFF8D9199),
  onInverseSurface: Color(0xFF201A18),
  inverseSurface: Color(0xFFEDE0DC),
  inversePrimary: Color(0xFFb02f00),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF7C7D81),
  outlineVariant: Color(0xFF52443D),
  scrim: Color(0xFF000000),
);
