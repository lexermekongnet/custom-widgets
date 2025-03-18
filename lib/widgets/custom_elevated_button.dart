import 'package:flutter/material.dart';

/// A custom widget for customized [ElevatedButton] ui
class CustomElevatedButton extends StatelessWidget {
  /// Creates an instance of [CustomElevatedButton]
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.width,
    this.height,
  });

  /// This is the on press function
  final void Function()? onPressed;

  /// The child of the widget
  final Widget? child;

  /// This is the background color of the button
  final Color? backgroundColor;

  /// This is the [ElevatedButton] width
  final double? width;

  /// This is the [ElevatedButton] height
  final double? height;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryAction = theme.colorScheme.primary;
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: backgroundColor ?? primaryAction,
          disabledBackgroundColor: backgroundColor?.withValues(alpha: 0.5) ??
              primaryAction.withValues(alpha: 0.5),
        ),
        child: child,
      ),
    );
  }
}
