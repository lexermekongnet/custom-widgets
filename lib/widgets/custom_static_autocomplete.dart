import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'custom_icon_button.dart';
import 'custom_text.dart';
import 'custom_text_form_field.dart';

/// A custom [Autocomplete] widget
class CustomStaticAutocomplete extends StatefulWidget {
  /// Creates an instance of [CustomStaticAutocomplete]
  const CustomStaticAutocomplete({
    super.key,
    required this.icon,
    required this.label,
    required this.options,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.controller,
  });

  /// The label of the autocomplete
  final String label;

  /// The options of the autocomplete
  final List<({String label, dynamic value})> options;

  /// The validator of the autocomplete
  final String? Function(String?)? validator;

  /// The on saved of the autocomplete
  final void Function(String)? onSaved;

  /// The on changed of the autocomplete
  final void Function(({String label, dynamic value}))? onChanged;

  /// The icon of the autocomplete
  final Widget icon;

  /// The controller of the autocomplete
  final TextEditingController? controller;
  @override
  State<CustomStaticAutocomplete> createState() =>
      _CustomStaticAutocompleteState();
}

class _CustomStaticAutocompleteState extends State<CustomStaticAutocomplete> {
  TextEditingController? _textEditingController;
  FocusNode? _focusNode;
  final _textKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      key: _textKey,
      displayStringForOption: (option) => option.label,
      fieldViewBuilder: (
        context,
        textEditingController,
        focusNode,
        onFieldSubmitted,
      ) {
        if (_textEditingController == null) {
          _textEditingController ??= textEditingController;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _textEditingController?.addListener(() {
              if (!mounted) return;
              setState(() {});
            });
          });
          if (widget.controller?.text != null) {
            final options =
                widget.options.where((element) {
                  dynamic value = element.value;
                  if (value is! String) value = value.toString();
                  return value.toLowerCase().contains(
                    widget.controller!.text.toLowerCase(),
                  );
                }).toList();
            if (options.isNotEmpty) {
              _textEditingController?.text = options.first.label;
              widget.onChanged?.call(options.first);
            }
          }
        }
        if (_focusNode == null) {
          _focusNode ??= focusNode;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _focusNode?.addListener(() {
              if (!mounted) return;
              setState(() {});
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_textKey.currentContext != null) {
                  Scrollable.ensureVisible(
                    _textKey.currentContext!,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              });
            });
          });
        }

        bool hasFocus = _focusNode?.hasFocus ?? focusNode.hasFocus;

        Widget suffixIcon = CustomIconButton(
          splashColor: Colors.transparent,
          icon: Icon(hasFocus ? Icons.arrow_drop_up : Icons.arrow_drop_down),
          onPressed: () {
            if (hasFocus) {
              _focusNode?.unfocus();
            } else {
              _focusNode?.requestFocus();
            }
          },
        );
        if (textEditingController.text.isNotEmpty) {
          suffixIcon = CustomIconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              textEditingController.clear();
              _focusNode?.unfocus();
              widget.onChanged?.call((label: '', value: ''));
            },
          );
        }
        final text = widget.controller?.text;
        if (text != null) {
          if (text.isNotEmpty &&
              text != (_textEditingController ?? textEditingController).text) {
            (_textEditingController ?? textEditingController).text = text;
          }
        }
        return CustomTextFormField(
          prefixIcon: widget.icon,
          labelText: widget.label,
          hintText: widget.label,
          controller: _textEditingController,
          focusNode: _focusNode,
          onFieldSubmitted: (text) {
            if (text.isEmpty) return;
            onFieldSubmitted();
          },
          suffixIcon: suffixIcon,
          textInputAction: TextInputAction.done,
          validator:
              widget.validator ??
              (value) {
                if (widget.options
                    .where(
                      (element) =>
                          element.label.toLowerCase() == value?.toLowerCase(),
                    )
                    .isEmpty) {
                  return '*Invalid';
                }
                return null;
              },
          onSaved: (x) {
            final option = widget.options.firstWhereOrNull(
              (element) => element.label.toLowerCase() == x.toLowerCase(),
            );
            if (option == null) return;
            widget.onChanged?.call(option);
          },
          onChanged: (x) {
            widget.controller?.text = x;
            final option = widget.options.firstWhereOrNull(
              (element) => element.label.toLowerCase() == x.toLowerCase(),
            );
            if (option == null) return;
            widget.onChanged?.call(option);
          },
        );
      },
      optionsBuilder: (text) {
        final options =
            widget.options
                .where(
                  (element) => element.label.toLowerCase().contains(
                    text.text.toLowerCase(),
                  ),
                )
                .toList();
        if (options.isEmpty) {
          return [(label: 'EMPTY', value: 'empty')];
        }
        return options;
      },
      optionsViewBuilder: (context, onSelected, options) {
        Widget child = SizedBox.shrink();
        final textFieldBox =
            _textKey.currentContext?.findRenderObject() as RenderBox;
        double textFieldWidth = textFieldBox.size.width;
        if (options.isEmpty || options.length == 1) {
          if (options.isNotEmpty &&
              options.first.value == 'empty' &&
              options.first.label == 'EMPTY') {
            child = Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 50,
                width: 200,
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  elevation: 4,
                  child: Center(
                    child: CustomText(
                      'No options found',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }
        }

        if (options.isNotEmpty &&
            options.first.value != 'empty' &&
            options.first.label != 'EMPTY') {
          child = Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 200,
              width: textFieldWidth,
              child: Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                elevation: 4,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final option = options.toList()[index];
                    return ListTile(
                      title: CustomText(option.label),
                      onTap: () {
                        onSelected(option);
                        widget.onChanged?.call(option);
                        FocusScope.of(context).unfocus();
                      },
                    );
                  },
                  separatorBuilder: (context, index) => Divider(height: 1),
                  itemCount: options.length,
                ),
              ),
            ),
          );
        }
        return child;
      },
    );
  }
}
