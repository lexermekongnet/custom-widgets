import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../resource/asset.dart';
import '../resource/color.dart';

/// A custom widget class of [Shimmer] with MekongNet M
class CustomLoadingWidget extends StatelessWidget {
  /// Creates an instance of [CustomLoadingWidget]
  const CustomLoadingWidget({super.key, this.indicatorColor});

  /// This is the background color
  final Color? indicatorColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return Center(
      child: Shimmer.fromColors(
        baseColor: mekongOrange(isLight),
        highlightColor: const Color(0xff6e6f71),
        child: Image.asset(
          appIcon,
          height: 72,
          width: 72,
          color: mekongOrange(isLight),
        ),
      ),
    );
  }
}
