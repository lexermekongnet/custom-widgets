import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../resource/text_style.dart';
import 'custom_elevated_button.dart';
import 'custom_icon_button.dart';
import 'custom_text.dart';

/// A custom widget class for file picker form
class CustomFilePickerForm extends StatefulWidget {
  /// The label of the form
  final String label;

  /// The icon of the form
  final Icon icon;

  /// The boolean if the form is required
  final bool required;

  /// A callback function that is called when the form is changed
  final void Function(String)? onChanged;

  /// Creates an instance of [CustomFilePickerForm]
  const CustomFilePickerForm({
    super.key,
    required this.label,
    required this.icon,
    required this.required,
    this.onChanged,
  });

  @override
  State<CustomFilePickerForm> createState() => _CustomFilePickerFormState();
}

class _CustomFilePickerFormState extends State<CustomFilePickerForm> {
  String _fileName = '';
  bool? _isFilePicked;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorColor = theme.colorScheme.error;
    Color? labelColor;
    Color buttonColor = Colors.green;
    if (_isFilePicked == false) {
      labelColor = errorColor;
      buttonColor = errorColor;
    }
    return Stack(
      children: [
        TextFormField(
          style: customTextStyle(theme, fontColor: Colors.transparent),
          enabled: false,
          validator: (value) {
            if (widget.required && value!.isEmpty) {
              if (!mounted) return '*Required';
              setState(() {
                _isFilePicked = false;
              });
              return '*Required';
            }
            return null;
          },
          controller: TextEditingController(text: _fileName),
          decoration: InputDecoration(
            disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            errorStyle: customTextStyle(
              theme,
              fontSize: 10,
              fontColor: Colors.red,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 30,
              child: Row(
                children: [
                  widget.icon,
                  const SizedBox(width: 8),
                  Flexible(
                    child: CustomText(
                      widget.label,
                      overflow: TextOverflow.ellipsis,
                      fontColor: labelColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            if (_fileName.isEmpty)
              CustomElevatedButton(
                backgroundColor: buttonColor,
                onPressed: _pick,
                child: CustomText(
                  'Choose File',
                  fontColor: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (_fileName.isNotEmpty)
              Flexible(
                flex: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: CustomText(
                        _fileName,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    CustomIconButton(
                      color: Colors.green,
                      onPressed: _pick,
                      icon: Icon(Icons.change_circle),
                    ),
                    CustomIconButton(
                      color: Colors.red,
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                      ),
                      onPressed: () {
                        if (!mounted) return;
                        setState(() {
                          _fileName = '';
                        });
                        widget.onChanged?.call('');
                      },
                      icon: Icon(Icons.remove_circle),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  void _pick() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    final file = result.files.single;
    if (!mounted) return;
    setState(() {
      _fileName = file.name;
      _isFilePicked = true;
    });
    widget.onChanged?.call(file.path ?? '');
  }
}
