import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final int icon;
  final double? size;
  final Color? color;
  const CustomIcon(this.icon, {super.key, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(IconData(icon), size: size, color: color);
  }
}
