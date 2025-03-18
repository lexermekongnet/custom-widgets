import 'package:flutter/material.dart';

import 'custom_text.dart';

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
    super.width,
  }) : super(
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(12),
           side: BorderSide(
             color: borderColor ?? Colors.black,
           ), // Customize the border here
         ),
       );

  /// A method to show the snackbar
  static void show(BuildContext context, {required String message}) {
    final theme = Theme.of(context);
    final surface = theme.colorScheme.surface;
    final inverseSurface = theme.colorScheme.onSurface;
    final scaffoldMessengerContext = ScaffoldMessenger.of(context);
    scaffoldMessengerContext.showSnackBar(
      CustomSnackBar(
        backgroundColor: surface,
        borderColor: inverseSurface,
        content: CustomText(message),
      ),
    );
  }
}
