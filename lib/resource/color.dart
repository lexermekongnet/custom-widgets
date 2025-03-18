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

/// This is the default white
Color mekongWhite(bool isLight) {
  const originalColor = Colors.white;
  if (isLight) return originalColor;
  return Colors.white70;
}
