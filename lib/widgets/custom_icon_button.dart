import 'dart:async';

import 'package:flutter/material.dart';

/// A custom widget for customized [IconButton] ui
class CustomIconButton extends StatefulWidget {
  /// The icon of the widget
  final Widget icon;

  /// The color of the widget
  final Color? color;

  /// The splash color of the widget
  final Color? splashColor;

  /// The splash radius of the widget
  final double? splashRadius;

  /// The visual density of the widget
  final VisualDensity? visualDensity;

  /// The padding of the widget
  final EdgeInsetsGeometry? padding;

  /// This is the on press function
  final void Function()? onPressed;

  /// Creates an instance of [CustomIconButton]
  const CustomIconButton({
    super.key,
    required this.icon,
    this.splashRadius,
    this.color,
    this.splashColor,
    this.visualDensity,
    this.padding,
    required this.onPressed,
  });

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  Timer? _timer;
  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: widget.splashRadius,
      splashColor: widget.splashColor,
      color: widget.color,
      padding: widget.padding,
      visualDensity: widget.visualDensity,
      onPressed:
          widget.onPressed != null
              ? () {
                _timer?.cancel();
                _timer = Timer(const Duration(milliseconds: 300), () {
                  widget.onPressed!();
                });
              }
              : null,
      icon: widget.icon,
    );
  }
}
