import 'package:flutter/material.dart';

/// A custom widget of [SnackBar]
class CustomSnackBar extends SnackBar {
  /// Creates an instance of [CustomSnackBar]
  CustomSnackBar({
    super.key,
    required super.content,
    super.backgroundColor,
    Color? borderColor,
    super.duration = const Duration(seconds: 2),
    SnackBarBehavior super.behavior = SnackBarBehavior.floating,
    super.margin,
    super.elevation,
  }) : super(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: borderColor ?? Colors.black,
            ), // Customize the border here
          ),
        );
}
