import 'package:flutter/material.dart';

const _fontFamily = 'Helvetica';

/// This method returns a shared [TextStyle]
TextStyle customTextStyle(
  ThemeData theme, {
  double? fontSize,
  Color? fontColor,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  String? fontFamily,
}) {
  final isLight = theme.brightness == Brightness.light;
  Color defaultTextColor = Colors.white;
  if (isLight) defaultTextColor = Colors.black;

  return TextStyle(
    fontFamily: fontFamily ?? _fontFamily,
    fontSize: fontSize,
    color: fontColor ?? defaultTextColor,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    textBaseline: TextBaseline.alphabetic,
  );
}
