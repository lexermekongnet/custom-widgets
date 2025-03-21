import 'package:flutter/material.dart';

import 'custom_text.dart';

/// A custom widget of [Switch]
class CustomSwitch extends StatefulWidget {
  /// The value of the switch
  final bool value;

  /// The title of the switch
  final String title;

  /// The function to be called when the switch is changed
  final void Function(bool)? onChanged;

  /// Creates an instance of [CustomSwitch]
  const CustomSwitch({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool _value = false;
  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: onSurface),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
        title: CustomText(widget.title),
        trailing: Switch(
          value: _value,
          onChanged: (value) {
            if (!mounted) return;
            setState(() {
              _value = value;
            });
            widget.onChanged?.call(value);
          },
        ),
      ),
    );
  }
}
