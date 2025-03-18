import 'package:flutter/material.dart';

import '../resource/asset.dart';
import '../resource/color.dart';
import '../resource/text_style.dart';

/// A custom widget class for MekongNet's logo
class MekongNetLogo extends StatelessWidget {
  /// This is the logo color
  final Color? logoColor;

  /// This is the font color "Mekong"
  final Color? fontColor;

  /// This is the alternative color
  final Color? altColor;

  /// Creates an instance of [MekongNetLogo]
  const MekongNetLogo({
    super.key,
    this.size = 24,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.logoColor,
    this.fontColor,
    this.altColor,
  });

  /// This is the logo size
  final double size;

  /// This is the [Row] alignment
  final MainAxisAlignment mainAxisAlignment;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Image.asset(
          appIcon,
          height: size * 2,
          width: size * 2,
          color: logoColor ?? mekongOrange(isLight),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Mekong',
            style: customTextStyle(
              theme,
              fontFamily: 'Beware',
              fontColor: fontColor ?? mekongOrange(isLight),
              fontSize: size,
            ),
            children: [
              TextSpan(
                text: 'Net',
                style: customTextStyle(
                  theme,
                  fontFamily: 'Beware',
                  fontColor: altColor ??
                      (isLight
                          ? const Color(0xff6c6e71)
                          : const Color(0xffbbbbbb)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
