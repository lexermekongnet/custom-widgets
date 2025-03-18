import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../resource/color.dart';

/// A widget class for shimmering / loading widgets
class CustomShimmer extends StatelessWidget {
  /// Creates an instance of [CustomShimmer]
  const CustomShimmer({super.key, required this.child});

  /// This is the child widget
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tertiary = theme.colorScheme.tertiary;
    final surface = theme.colorScheme.surface;
    final isLight = theme.brightness == Brightness.light;

    return Shimmer.fromColors(
      baseColor: tertiary.withValues(alpha: 0.2),
      highlightColor: mekongOrange(isLight),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: surface,
        ),
        child: child,
      ),
    );
  }
}
