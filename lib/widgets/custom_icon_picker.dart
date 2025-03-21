import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import 'custom_elevated_button.dart';
import 'custom_text.dart';

/// A custom widget for picking icons
class CustomIconPicker extends StatefulWidget {
  /// The icon code point
  final int codePoint;

  /// A function to be called when the icon is changed
  final void Function(int)? onChanged;

  /// Creates a custom icon picker
  const CustomIconPicker({super.key, required this.codePoint, this.onChanged});

  @override
  State<CustomIconPicker> createState() => _CustomIconPickerState();
}

class _CustomIconPickerState extends State<CustomIconPicker> {
  IconData _icon = Icons.abc;

  @override
  void initState() {
    super.initState();
    _icon = IconData(widget.codePoint, fontFamily: 'MaterialIcons');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(_icon, size: 32),
        CustomElevatedButton(
          backgroundColor: Colors.green,
          onPressed: () async {
            final icon = await showIconPicker(context);
            if (icon == null) return;
            if (!mounted) return;
            setState(() {
              _icon = icon;
            });
            widget.onChanged?.call(icon.codePoint);
          },
          child: CustomText('Choose Icon', fontColor: Colors.white),
        ),
      ],
    );
  }
}
