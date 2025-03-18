import 'package:flutter/material.dart';

/// A custom widget of [Container] with shadow
class CustomContainerWithShadow extends StatelessWidget {
  /// This is the child of the container
  final Widget child;

  /// This is the onTap callback of the container
  final void Function()? onTap;

  /// This is the content padding of the container
  final EdgeInsetsGeometry contentPadding;

  /// This is the background color of the container
  final Color? backgroundColor;

  /// Creates an instance of [CustomContainerWithShadow]
  const CustomContainerWithShadow({
    super.key,
    this.onTap,
    required this.child,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final color = backgroundColor ?? theme.colorScheme.primary;
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 0.5,
            blurStyle: isLight ? BlurStyle.inner : BlurStyle.normal,
            offset: isLight ? const Offset(2.0, 2.0) : Offset.zero,
            blurRadius: 10,
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: contentPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}
