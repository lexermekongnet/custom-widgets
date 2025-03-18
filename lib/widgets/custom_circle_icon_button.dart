import 'package:flutter/material.dart';

import 'custom_icon_button.dart';

/// A custom widget for circle icon button
class CustomCircleIconButton extends StatelessWidget {
  /// This is the icon of the button
  final Widget icon;

  /// This is the onPressed function
  final void Function()? onPressed;

  /// This is the background color of the button
  final Color? backgroundColor;

  /// Creates an instance of [CustomCircleIconButton]
  const CustomCircleIconButton({
    super.key,
    required this.icon,
    this.backgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryAction = theme.colorScheme.primary;
    return CircleAvatar(
      radius: 14,
      backgroundColor: backgroundColor ?? primaryAction,
      child: CustomIconButton(
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}
