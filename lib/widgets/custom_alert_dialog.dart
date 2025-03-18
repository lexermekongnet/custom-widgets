import 'package:flutter/material.dart';

/// A custom widget of [AlertDialog]
class CustomAlertDialog extends StatelessWidget {
  /// Creates an instance of [CustomAlertDialog]
  const CustomAlertDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.contentPadding,
    this.actionsAlignment,
  });

  /// This is the title of [AlertDialog]
  final Widget? title;

  /// This is the content of [AlertDialog]
  final Widget? content;

  /// This is the actions of [AlertDialog]
  final List<Widget>? actions;

  ///This is the contentPadding of [AlertDialog]
  final EdgeInsetsGeometry? contentPadding;

  /// This is the actionsAlignment of [AlertDialog]
  final MainAxisAlignment? actionsAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surface = theme.colorScheme.surface;
    return AlertDialog(
      actionsAlignment: actionsAlignment,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: surface,
      contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(32, 8, 32, 8),
      title: title,
      content: content,
      actions: actions,
    );
  }
}
