import 'package:flutter/material.dart';

import '../resource/text_style.dart';

/// A custom widget of [ListTile]
class CustomListTile extends StatelessWidget {
  /// Creates an instance of [CustomListTile]
  const CustomListTile({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.contentPadding,
    this.shape,
    this.tileColor,
    this.onTap,
  });

  /// This is the title widget
  final Widget? title;

  /// This is the subtitle widget
  final Widget? subtitle;

  /// This is the leading widget that appears on the left
  final Widget? leading;

  /// This is the trailing widget that appears on the right
  final Widget? trailing;

  /// This is the content padding
  final EdgeInsetsGeometry? contentPadding;

  /// This is the tile color
  final Color? tileColor;

  /// This is the tile shape
  final ShapeBorder? shape;

  /// This is the tile onTap callback
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      onTap: onTap,
      child: ListTile(
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        contentPadding: contentPadding ?? EdgeInsets.zero,
        tileColor: tileColor,
        shape: shape,
        titleTextStyle: customTextStyle(theme),
        subtitleTextStyle: customTextStyle(theme),
        leadingAndTrailingTextStyle: customTextStyle(theme),
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
      ),
    );
  }
}
