import 'package:flutter/material.dart';

import '../resource/color.dart';

/// A custom widget of [CircularProgressIndicator]
class CustomTextLoading extends StatelessWidget {
  /// This is the color of the [CircularProgressIndicator]
  final Color? color;

  /// Creates an instance of [CustomTextLoading]
  const CustomTextLoading({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    return SizedBox(
      width: 16,
      height: 16,
      child: CircularProgressIndicator(
        color: color ?? mekongWhite(isLight),
        strokeWidth: 2,
      ),
    );
  }
}
