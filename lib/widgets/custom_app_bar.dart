import 'package:flutter/material.dart';

import '../resource/color.dart';
import '../resource/text_style.dart';

/// A custom widget for customized [AppBar] ui
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// This is the [AppBar] leading widget
  /// Appears on the left side of the [AppBar]
  final Widget? leading;

  /// This is the [AppBar] bottom widget
  /// Appears on the bottom side of the [AppBar]
  final PreferredSizeWidget? bottom;

  /// This is the [AppBar] actions
  /// Appears on the right side of the [AppBar]
  final List<Widget>? actions;

  /// This is the condition whether [title] would be centralized
  final bool? centerTitle;

  /// This is the title of the [AppBar]
  final Widget? title;

  /// This is the app bar background color of the [AppBar]
  final Color? backgroundColor;

  /// This is the condition whether [leading] would be automatically imply
  final bool automaticallyImplyLeading;

  /// This is the flexible space of the [AppBar]
  final Widget? flexibleSpace;

  /// Creates an instance of [CustomAppBar]
  const CustomAppBar({
    super.key,
    this.leading,
    this.bottom,
    this.actions,
    this.centerTitle,
    this.title,
    this.backgroundColor,
    this.automaticallyImplyLeading = true,
    this.flexibleSpace,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        flexibleSpace: flexibleSpace,
        automaticallyImplyLeading: automaticallyImplyLeading,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: mekongOrange(isLight)),
        titleTextStyle: customTextStyle(theme),
        backgroundColor: backgroundColor,
        bottom: bottom,
        leading: leading,
        actions: actions,
        centerTitle: centerTitle,
        title: title,
      ),
    );
  }

  @override
  Size get preferredSize {
    // Base height is the toolbar height
    double height = kToolbarHeight;

    // Add the height of the bottom widget, if present
    if (bottom != null) {
      height += bottom!.preferredSize.height;
    }

    return Size.fromHeight(height);
  }
}
