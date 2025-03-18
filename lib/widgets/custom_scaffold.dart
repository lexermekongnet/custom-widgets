import 'package:flutter/material.dart';

/// A custom widget for customized [Scaffold] ui
class CustomScaffold extends StatelessWidget {
  /// Creates an instance of [CustomScaffold]
  const CustomScaffold({
    super.key,
    this.appBar,
    this.customKey,
    this.backgroundColor,
    required this.body,
    this.drawer,
    this.endDrawer,
    this.resizeToAvoidBottomInset,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.extendBodyBehindAppBar = false,
    this.extendBody = false,
  });

  /// This is the background color of the [AppBar]
  final Color? backgroundColor;

  /// This is the body of the [Scaffold]
  final Widget body;

  /// This is the [AppBar] of the [Scaffold]
  final PreferredSizeWidget? appBar;

  /// This is the drawer of the [Scaffold]
  /// Appears on the start / left side of the [AppBar]
  final Widget? drawer;

  /// This is the end drawer of the [Scaffold]
  /// Appears on the end / right side of the [AppBar]
  final Widget? endDrawer;

  /// This is the custom key for custom scaffold
  /// Used for [ScaffoldState] actions
  final GlobalKey<ScaffoldState>? customKey;

  /// If true the [body] and the scaffold's floating widgets should size themselves to avoid the onscreen keyboard whose height is defined by the ambient [MediaQuery]'s [MediaQueryData.viewInsets] bottom property.
  final bool? resizeToAvoidBottomInset;

  /// This is the [BottomNavigationBar] of the [Scaffold]
  /// Appears on the bottom side of the [Scaffold]
  final Widget? bottomNavigationBar;

  /// This is the floating action button of the [Scaffold]
  /// Appears on the bottom side of the [Scaffold]
  final Widget? floatingActionButton;

  /// This is the position of [floatingActionButton]
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// This is the condition whether [Scaffold] body would be extended to app bar or not
  final bool extendBodyBehindAppBar;

  /// This is the condition whether [Scaffold] body would be extended to bottom navigation bar or not
  final bool extendBody;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      key: customKey,
      appBar: appBar,
      body: body,
      drawer: drawer,
      endDrawer: endDrawer,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      extendBody: extendBody,
    );
  }
}
