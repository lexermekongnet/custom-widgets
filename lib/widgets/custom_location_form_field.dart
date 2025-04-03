import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'custom_text_form_field.dart';

/// A custom [TextFormField] for selecting location via map
class CustomLocationFormField extends StatefulWidget {
  /// Creates an instance of [CustomLocationFormField]
  const CustomLocationFormField({
    super.key,
    required this.icon,
    this.latitudeTextController,
    this.longitudeTextController,
    this.onSavedLatitude,
    this.onSavedLongitude,
    this.labelText,
    this.initialValue,
    this.latitudeValidator,
    this.longitudeValidator,
    this.onLocationTap,
  });

  /// The icon of the location form field
  final Widget icon;

  /// This is [TextFormField] label text
  final String? labelText;

  /// This is [TextFormField] initial value
  final String? initialValue;

  /// This is [TextFormField] latitude text controller
  final TextEditingController? latitudeTextController;

  /// This is [TextFormField] longitude text controller
  final TextEditingController? longitudeTextController;

  /// This is [TextFormField] on Saved latitude call back
  final void Function(String)? onSavedLatitude;

  /// This is [TextFormField] on Saved latitude call back
  final void Function(String)? onSavedLongitude;

  /// This is [TextFormField] latitude validator call back
  final String? Function(String?)? latitudeValidator;

  /// This is [TextFormField] longitude validator call back
  final String? Function(String?)? longitudeValidator;

  /// This is [TextFormField] on location tap call back
  final void Function()? onLocationTap;

  @override
  State<CustomLocationFormField> createState() =>
      _CustomLocationFormFieldState();
}

class _CustomLocationFormFieldState extends State<CustomLocationFormField> {
  bool isLatitudeClearVisible = false;
  bool isLongitudeClearVisible = false;

  final _latitudeFocusNode = FocusNode();
  final _longitudeFocusNode = FocusNode();

  @override
  void initState() {
    isLatitudeClearVisible =
        widget.latitudeTextController?.text.isNotEmpty == true;
    isLongitudeClearVisible =
        widget.longitudeTextController?.text.isNotEmpty == true;

    widget.latitudeTextController?.addListener(() {
      final isLatitudeNotEmpty = widget.latitudeTextController?.text.isNotEmpty;
      if (!mounted) return;
      if (isLatitudeClearVisible == isLatitudeNotEmpty) return;
      setState(() {
        isLatitudeClearVisible = !isLatitudeClearVisible;
      });
    });
    widget.longitudeTextController?.addListener(() {
      final isLongitudeNotEmpty =
          widget.longitudeTextController?.text.isNotEmpty;
      if (!mounted) return;
      if (isLongitudeClearVisible == isLongitudeNotEmpty) return;
      setState(() {
        isLongitudeClearVisible = !isLongitudeClearVisible;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.latitudeTextController?.removeListener(() {});
    widget.longitudeTextController?.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    focusNode: _latitudeFocusNode,
                    prefixIcon: widget.icon,
                    initialValue: widget.initialValue,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                    ],
                    onSaved: widget.onSavedLatitude,
                    controller: widget.latitudeTextController,
                    validator: widget.latitudeValidator,
                    hintText: 'Latitude',
                    labelText: 'Latitude',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    maxLines: 1,
                    suffix: Visibility(
                      visible: isLatitudeClearVisible,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        onPressed: () {
                          if (!mounted) return;
                          widget.latitudeTextController?.clear();
                        },
                        icon: const Icon(Icons.close, color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    focusNode: _longitudeFocusNode,
                    prefixIcon: widget.icon,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                    ],
                    controller: widget.longitudeTextController,
                    hintText: 'Longitude',
                    labelText: 'Longitude',
                    onSaved: widget.onSavedLongitude,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    maxLines: 1,
                    validator: widget.longitudeValidator,
                    suffix: Visibility(
                      visible: isLongitudeClearVisible,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        onPressed: () {
                          if (!mounted) return;
                          widget.longitudeTextController?.clear();
                        },
                        icon: const Icon(Icons.close, color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () async {
                _latitudeFocusNode.unfocus();
                _longitudeFocusNode.unfocus();
                widget.onLocationTap?.call();
              },
              icon: const Icon(Icons.gps_fixed),
            ),
          ],
        ),
      ],
    );
  }
}
