import 'package:flutter/material.dart';

import '../resource/color.dart';
import 'custom_text.dart';

/// A widget class for custom [Row] that looks like [ListTile] without tile color
class CustomInfoRow extends StatelessWidget {
  /// Creates an instance of [CustomInfoRow]
  const CustomInfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.suffix,
    this.iconColor,
    this.titleColor,
    this.valueColor,
    this.titleSize,
    this.valueSize,
  });

  /// This is the leading icon
  final IconData icon;

  /// This is the title
  final String title;

  /// This is the "value" appears on the trail
  final String value;

  /// This is the suffix widget
  final Widget? suffix;

  /// This is the icon color
  final Color? iconColor;

  /// This is the icon color
  final Color? titleColor;

  /// This is the icon color
  final Color? valueColor;

  /// This is the icon color
  final double? titleSize;

  /// This is the icon color
  final double? valueSize;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                Icon(icon, color: iconColor ?? mekongOrange(isLight)),
                const SizedBox(width: 8),
                Flexible(
                  child: CustomText(
                    title,
                    overflow: TextOverflow.visible,
                    fontColor: titleColor,
                    fontSize: titleSize,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: CustomText(
                    value,
                    overflow: TextOverflow.visible,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.right,
                    fontColor: valueColor,
                    fontSize: valueSize,
                  ),
                ),
                if (suffix != null) suffix!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
