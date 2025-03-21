import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resource/text_style.dart';
import 'custom_icon_button.dart';

/// A custom widget for customized [TextFormField] ui
class CustomTextFormField extends StatefulWidget {
  /// Creates an instance of [CustomTextFormField]
  const CustomTextFormField({
    super.key,
    this.controller,
    this.keyboardType,
    this.maxLines,
    this.minLines,
    this.height,
    this.width,
    this.style,
    this.decoration,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.hintText,
    this.hintStyle,
    this.cursorColor,
    this.validator,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.borderRadius,
    this.enabled,
    this.labelText,
    this.labelTextStyle,
    this.alignLabelWithHint,
    this.focusNode,
    this.autovalidateMode,
    this.maxLength,
    this.onSaved,
    this.onFieldSubmitted,
    this.initialValue,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.inputFormatters,
    this.readOnly = false,
    this.onTap,
    this.enabledBorderSide,
    this.focusedBorderSide,
    this.errorBorderSide,
    this.prefixText,
    this.autofillHints,
    this.textInputAction,
    this.disabledBorder,
    this.prefixIconColor,
    this.suffixIconColor,
  });

  /// This is the text editing controller
  final TextEditingController? controller;

  /// This is the keyboard input type
  final TextInputType? keyboardType;

  /// This is the maximum amount of lines
  final int? maxLines;

  /// This is the minimum amount of lines
  final int? minLines;

  /// This is the custom height of the widget
  final double? height;

  /// This is the custom width of the widget
  final double? width;

  /// This is the text  style
  final TextStyle? style;

  /// This is the label text  style
  final TextStyle? labelTextStyle;

  /// This is the input decoration
  final InputDecoration? decoration;

  /// This is to hide text
  final bool obscureText;

  /// This is to enable suggestions
  final bool enableSuggestions;

  /// This is to use auto correct
  final bool autocorrect;

  /// This is the hint of text form field
  final String? hintText;

  /// This is the hint text  style
  final TextStyle? hintStyle;

  /// This is the cursor color
  final Color? cursorColor;

  /// This is the text form field validator
  final String? Function(String?)? validator;

  /// This is the on changed listener
  final void Function(String)? onChanged;

  /// This is the text alignment
  final TextAlign textAlign;

  /// This is the text form field border radius
  final BorderRadius? borderRadius;

  /// This is the text form field enabled condition
  final bool? enabled;

  /// This is the text form field label text
  final String? labelText;

  /// This is to align label text to top
  final bool? alignLabelWithHint;

  /// This handles the keyboard focus
  final FocusNode? focusNode;

  /// This is the maximum length of [TextFormField]
  final int? maxLength;

  /// This is the onSaved callback
  /// Triggers when you call [FormState.save]
  final void Function(String)? onSaved;

  /// This is the onTap callback
  final void Function()? onTap;

  /// This handles the automation of [validator]
  final AutovalidateMode? autovalidateMode;

  /// This is the initial value of the [TextFormField]
  final String? initialValue;

  /// This is the [TextFormField] prefix widget
  final Widget? prefix;

  /// This is the [TextFormField] prefix icon
  final Widget? prefixIcon;

  /// This is the [TextFormField] suffix widget
  final Widget? suffix;

  /// This is the [TextFormField] suffix icon
  final Widget? suffixIcon;

  /// This is the [TextFormField] input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// This is the custom disabled border
  final bool readOnly;

  /// This is the border side of enabled [TextFormField]
  final BorderSide? enabledBorderSide;

  /// This is the border side of focused [TextFormField]
  final BorderSide? focusedBorderSide;

  /// This is the border side of error [TextFormField]
  final BorderSide? errorBorderSide;

  /// This is the prefix text of [TextFormField]
  final String? prefixText;

  /// This is the autofillHints [TextFormField]
  final Iterable<String>? autofillHints;

  /// This is the onFieldSubmitted [TextFormField]
  final void Function(String)? onFieldSubmitted;

  /// This is the optional input action
  final TextInputAction? textInputAction;

  /// This is the disabled border style
  final InputBorder? disabledBorder;

  /// This is the prefix icon color
  final Color? prefixIconColor;

  /// This is the suffix icon color
  final Color? suffixIconColor;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool showPassword = false;
  late bool obscureText;
  late bool enableSuggestions;
  late bool autoCorrect;
  Color? labelColor;

  @override
  void initState() {
    obscureText = widget.obscureText;
    enableSuggestions = widget.enableSuggestions;
    autoCorrect = widget.autocorrect;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: TextFormField(
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        autofillHints: widget.autofillHints,
        readOnly: widget.readOnly,
        initialValue: widget.initialValue,
        maxLength: widget.maxLength,
        autovalidateMode: widget.autovalidateMode,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
        textAlign: widget.textAlign,
        validator: (value) {
          final validator = widget.validator?.call(value);
          if (validator != null) {
            if (!mounted) return validator;
            setState(() {
              labelColor = theme.colorScheme.error;
            });
            return validator;
          }
          if (!mounted) return validator;
          setState(() {
            labelColor = null;
          });
          return validator;
        },
        obscureText: obscureText,
        enableSuggestions: enableSuggestions,
        autocorrect: autoCorrect,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        style: widget.style ?? customTextStyle(theme),
        onChanged: widget.onChanged,
        decoration: widget.decoration ?? _textFormFieldDecoration(theme),
        controller: widget.controller,
        inputFormatters: widget.inputFormatters,
        onSaved: (newValue) => widget.onSaved?.call(newValue ?? ''),
        onTap: widget.onTap,
      ),
    );
  }

  InputDecoration _textFormFieldDecoration(ThemeData theme) {
    final inverseSurface = theme.colorScheme.inverseSurface;
    final error = theme.colorScheme.error;

    final borderSide = BorderSide(color: inverseSurface);
    final errorSide = BorderSide(color: error);
    Widget? suffixIcon = widget.suffixIcon;
    final passwordSuffix = CustomIconButton(
      onPressed: () {
        if (!mounted) return;
        setState(() {
          showPassword = !showPassword;
          obscureText = !obscureText;
          autoCorrect = !autoCorrect;
          enableSuggestions = !enableSuggestions;
        });
      },
      icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility),
      splashRadius: 10,
    );
    if (widget.keyboardType == TextInputType.visiblePassword) {
      suffixIcon = passwordSuffix;
    }
    return InputDecoration(
      prefixText: widget.prefixText,
      prefixStyle: widget.style,
      suffix: widget.suffix,
      suffixIcon: suffixIcon,
      suffixIconColor: widget.suffixIconColor,
      prefix: widget.prefix,
      prefixIcon: widget.prefixIcon,
      prefixIconColor: widget.prefixIconColor,
      alignLabelWithHint: widget.alignLabelWithHint,
      filled: true,
      fillColor: Colors.transparent,
      disabledBorder: widget.disabledBorder,
      enabledBorder: OutlineInputBorder(
        borderSide: widget.enabledBorderSide ?? borderSide,
        borderRadius:
            widget.borderRadius ?? const BorderRadius.all(Radius.circular(12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: widget.focusedBorderSide ?? borderSide,
        borderRadius:
            widget.borderRadius ?? const BorderRadius.all(Radius.circular(12)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: widget.errorBorderSide ?? errorSide,
        borderRadius:
            widget.borderRadius ?? const BorderRadius.all(Radius.circular(12)),
      ),
      border: OutlineInputBorder(
        borderRadius:
            widget.borderRadius ?? const BorderRadius.all(Radius.circular(12)),
      ),
      hintText: widget.hintText,
      errorStyle: customTextStyle(
        theme,
        fontSize: 10,
        fontColor: Colors.red,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
      hintStyle: customTextStyle(
        theme,
        fontColor: Colors.grey,
        fontStyle: FontStyle.italic,
      ),
      labelText: widget.labelText,
      labelStyle: customTextStyle(theme, fontSize: 14, fontColor: labelColor),
      contentPadding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
    );
  }
}
