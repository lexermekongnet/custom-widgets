import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../resource/color.dart';
import 'custom_text.dart';

/// A custom widget for showing small profile picture
class CustomSmallProfile extends StatefulWidget {
  /// This is the message that contains profile url
  final String profileUrl;

  /// This is the profile name
  final String profileName;

  /// Size of the CircleAvatar
  final double size;

  /// Creates an instance of [CustomSmallProfile]
  const CustomSmallProfile({
    super.key,
    this.profileUrl = '',
    this.profileName = '',
    this.size = 40.0, // Default size
  });

  @override
  State<CustomSmallProfile> createState() => _CustomSmallProfileState();
}

class _CustomSmallProfileState extends State<CustomSmallProfile> {
  String _getInitials(String name) {
    String profileName = name.trim();
    if (profileName.isEmpty) return '';
    final parts = profileName.split(' ');
    parts.removeWhere((element) => element.isEmpty);
    if (parts.isEmpty) return '';
    if (parts.first.isEmpty) return '';

    final firstInitial = parts.first[0].toUpperCase();
    if (parts.last.isEmpty) return firstInitial;
    final lastInitial = parts.length > 1 ? parts.last[0].toUpperCase() : '';

    return '$firstInitial$lastInitial';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surface = theme.colorScheme.surface;
    final isLight = theme.brightness == Brightness.light;
    final url = widget.profileUrl;
    if (!Uri.parse(url).isAbsolute) {
      final name = widget.profileName;
      final initials = _getInitials(name);
      Widget child = CustomText(
        initials,
        fontWeight: FontWeight.bold,
        fontSize: widget.size * 0.4, // Adjust text size proportionally
        fontColor: surface,
      );
      if (initials.isEmpty) {
        child = Icon(Icons.person, color: surface);
      }
      return SizedBox(
        width: widget.size,
        height: widget.size,
        child: CircleAvatar(
          backgroundColor: mekongOrange(isLight),
          child: child,
        ),
      );
    }

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CircleAvatar(backgroundImage: CachedNetworkImageProvider(url)),
    );
  }
}
