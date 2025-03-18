import 'package:flutter/material.dart';

import '../resource/text_style.dart';

/// A custom widget of [Text]
class CustomText extends StatelessWidget {
  /// Creates an instance of [CustomText] widget
  const CustomText(
    this.data, {
    super.key,
    this.fontFamily,
    this.fontSize,
    this.fontColor,
    this.fontWeight,
    this.fontStyle,
    this.maxLines,
    this.overflow,
    this.textAlign,
  });

  /// This is the text to show the user
  final String data;

  /// This is the custom font family of the text
  final String? fontFamily;

  /// This is the font size of the text
  final double? fontSize;

  /// This is the font size of the text
  final Color? fontColor;

  /// This is the font weight of the text
  final FontWeight? fontWeight;

  /// This is the font style of the text
  final FontStyle? fontStyle;

  /// This is the max lines of the text
  final int? maxLines;

  /// This is the text overflow behavior
  final TextOverflow? overflow;

  /// This is the text alignment
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: customTextStyle(
        theme,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontColor: fontColor,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      ),
      data,
    );
  }
}
