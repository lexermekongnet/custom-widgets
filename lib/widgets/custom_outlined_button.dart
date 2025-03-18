import 'package:flutter/material.dart';

/// A custom widget for customized [ElevatedButton] ui
class CustomOutlinedButton extends StatelessWidget {
  /// Creates an instance of [CustomOutlinedButton]
  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color,
    this.backgroundColor,
    this.width,
    this.height,
    this.borderRadius = 12,
  });

  /// This is the on press function
  final void Function()? onPressed;

  /// The child of the widget
  final Widget? child;

  /// This is the border color of the button
  final Color? color;

  /// This is the background color of the button
  final Color? backgroundColor;

  /// This is the [OutlinedButton] width
  final double? width;

  /// This is the [OutlinedButton] height
  final double? height;

  /// This is the [OutlinedButton] border radius
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryAction = theme.colorScheme.primary;
    final color = this.color ?? primaryAction;

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: backgroundColor,
          side: BorderSide(color: color),
          disabledBackgroundColor: Colors.grey[300],
        ),
        child: child,
      ),
    );
  }
}
