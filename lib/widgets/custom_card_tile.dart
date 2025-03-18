import 'package:flutter/material.dart';

import 'custom_card.dart';
import 'custom_list_tile.dart';

/// A custom widget of both [Card] and [CustomListTile]
class CustomCardTile extends StatelessWidget {
  /// Creates an instance of [CustomCardTile]
  const CustomCardTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.contentPadding = const EdgeInsets.fromLTRB(32, 8, 32, 8),
    this.onTap,
    this.borderWidth = 0.5,
  });

  /// This is the leading widget
  final Widget? leading;

  /// This is the title widget
  final Widget? title;

  /// This is the subtitle widget
  final Widget? subtitle;

  /// This is the trailing widget
  final Widget? trailing;

  /// This is the content padding
  final EdgeInsetsGeometry contentPadding;

  /// This is the onTap callback
  final void Function()? onTap;

  /// This is the border width of the card
  final double borderWidth;
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      borderWidth: borderWidth,
      child: CustomListTile(
        contentPadding: contentPadding,
        tileColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
