import 'package:flutter/material.dart';

/// A custom widget of [Card]
class CustomCard extends StatelessWidget {
  /// Creates an instance of [CustomCard]
  const CustomCard({
    super.key,
    this.backgroundColor,
    required this.child,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.onTap,
    this.onLongPress,
    this.borderWidth = 0.5,
    this.borderColor,
  });

  /// This is the custom background color of the card
  final Color? backgroundColor;

  /// This is the child content widget
  final Widget child;

  /// This is the onTap callback of the Card
  final void Function()? onTap;

  /// This is the onLongPress callback of the Card
  final void Function()? onLongPress;

  /// This is the content padding of the card
  final EdgeInsetsGeometry contentPadding;

  /// This is the border width of the card
  final double borderWidth;

  /// This is the custom border color
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    Color? surfaceTintColor = theme.colorScheme.surface;
    Color? borderColor =
        this.borderColor ?? theme.colorScheme.primary.withValues(alpha: 0.7);
    if (isDark) {
      surfaceTintColor = null;
      borderColor = Colors.white;
    }

    return Material(
      color: Colors.transparent,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            width: borderWidth,
            color: borderColor,
          ),
        ),
        color: backgroundColor,
        surfaceTintColor: surfaceTintColor,
        elevation: 0.5,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            onLongPress: onLongPress,
            child: Padding(
              padding: contentPadding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
