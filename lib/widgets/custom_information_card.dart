import 'package:flutter/material.dart';

import 'custom_card.dart';
import 'custom_container_with_shadow.dart';

/// A custom widget of [CustomCard] and [CustomContainerWithShadow]
class CustomInformationCard extends StatelessWidget {
  /// This is the child of the card
  final Widget child;

  /// This is the onTap callback of the card
  final void Function()? onTap;

  /// This is the content padding of the child
  final EdgeInsetsGeometry contentPadding;

  /// This is the background color of the card
  final Color? backgroundColor;

  /// This is the background color of the card
  final Color? borderColor;

  /// This is the border width of the card
  final double borderWidth;

  /// Creates an instance of [CustomInformationCard]
  const CustomInformationCard({
    super.key,
    this.onTap,
    required this.child,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    if (isLight) {
      return CustomCard(
        borderColor: borderColor,
        borderWidth: borderWidth,
        backgroundColor: backgroundColor,
        contentPadding: contentPadding,
        onTap: onTap,
        child: child,
      );
    }
    return CustomContainerWithShadow(
      backgroundColor: backgroundColor,
      contentPadding: contentPadding,
      onTap: onTap,
      child: child,
    );
  }
}
