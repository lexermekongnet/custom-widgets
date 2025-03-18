import 'package:flutter/material.dart';

import 'custom_elevated_button.dart';
import 'custom_text_loading.dart';

/// A custom widget with combination of [CustomElevatedButton] and [CustomTextLoading]
class CustomElevatedLoadingButton extends StatelessWidget {
  /// Creates an instance of [CustomElevatedLoadingButton]
  const CustomElevatedLoadingButton({
    super.key,
    this.backgroundColor,
    this.width,
  });

  /// This is the custom background color of the button
  final Color? backgroundColor;

  /// This is the custom width
  final double? width;
  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      width: width,
      backgroundColor: backgroundColor,
      onPressed: null,
      child: const CustomTextLoading(),
    );
  }
}
