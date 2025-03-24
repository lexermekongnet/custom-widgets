import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../resource/color.dart';
import 'custom_icon_button.dart';
import 'custom_text.dart';
import 'custom_text_form_field.dart';

/// A custom widget class for auto complete widget
class CustomDynamicAutocomplete extends StatefulWidget {
  /// Creates an instance of [CustomDynamicAutocomplete]
  const CustomDynamicAutocomplete({
    super.key,
    this.enabled,
    this.onSelected,
    this.labelText,
    this.hintText,
    this.validator,
    this.optionsViewOpenDirection = OptionsViewOpenDirection.down,
    this.onSaved,
    this.onClear,
    this.onChanged,
    this.onLoadMore,
    this.onAutoCompleteBuild,
    this.prefixIcon,
    this.textInputAction,
    this.onFieldSubmitted,
    this.suffixIcon = const SizedBox(),
    this.controller,
  });

  /// This is the autocomplete label text
  final String? labelText;

  /// This is the autocomplete hint text
  final String? hintText;

  /// This is the select dropdown callback
  final void Function(({String text, dynamic value}))? onSelected;

  /// This is the validator callback
  final String? Function(String?)? validator;

  /// This is the direction of the autocomplete body
  final OptionsViewOpenDirection optionsViewOpenDirection;

  /// This is enable condition
  final bool? enabled;

  /// This is the onSaved callback
  final void Function(dynamic)? onSaved;

  /// This is the onSaved callback
  final void Function()? onClear;

  /// This is the on load more callback
  final void Function()? onLoadMore;

  /// This is the onAutoComplete built
  final void Function(TextEditingController)? onAutoCompleteBuild;

  /// This is the onChange callback
  final void Function(dynamic)? onChanged;

  /// This is the icon on the left
  final Widget? prefixIcon;

  /// This is the optional input action
  final TextInputAction? textInputAction;

  /// This is the onChange callback
  final void Function(dynamic)? onFieldSubmitted;

  /// This is the icon on the right
  final Widget suffixIcon;

  /// This is the optional [TextEditingController]
  final TextEditingController? controller;

  @override
  CustomDynamicAutocompleteState createState() =>
      CustomDynamicAutocompleteState();
}

/// A state class of [CustomDynamicAutocomplete]
class CustomDynamicAutocompleteState extends State<CustomDynamicAutocomplete> {
  late TextEditingController _controller;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _textKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();
  List<({String text, dynamic value})> _suggestions = [];
  List<({String text, dynamic value})> _allSuggestions = [];
  Timer? _debouncer;

  bool _showLoading = false;

  /// Add new data
  void add(List<({String text, dynamic value})> data) {
    if (!mounted) return;
    setState(() {
      _allSuggestions = data;
      _suggestions = data;
    });
  }

  /// Add show loading
  void loading(bool isLoading) {
    if (!mounted) return;
    setState(() => _showLoading = isLoading);
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_textListener);
    _focusNode.addListener(_hasFocus);
    _scrollController.addListener(_onScroll);
    widget.onAutoCompleteBuild?.call(_controller);
  }

  void _onChanged(String value) {
    final suggestion = _getSuggestion(value);
    if (suggestion == null) return;
    widget.onChanged?.call(suggestion);
  }

  void _onSaved(String value) {
    final suggestion = _getSuggestion(value);
    if (suggestion == null) return;
    widget.onSaved?.call(suggestion);
  }

  ({String text, dynamic value})? _getSuggestion(String value) {
    if (!mounted) return null;
    setState(() {
      _suggestions =
          _allSuggestions
              .where(
                (item) => item.text.toLowerCase().contains(value.toLowerCase()),
              )
              .toList();
    });
    return _suggestions.firstWhereOrNull(
      (element) => element.text.toLowerCase() == value.toLowerCase(),
    );
  }

  void _onScroll() {
    final ScrollController(:offset, :position) = _scrollController;
    final maxExtent = position.maxScrollExtent;
    final maxScrollReached = offset >= maxExtent;
    _debouncer?.cancel();
    _debouncer = Timer(const Duration(milliseconds: 900), () {
      if (maxScrollReached) widget.onLoadMore?.call();
      if (!mounted) return;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_hasFocus);
    _controller.removeListener(_textListener);
    _scrollController.removeListener(_onScroll);
    _focusNode.dispose();
    _scrollController.dispose();
    if (widget.controller == null) _controller.dispose();
    _debouncer?.cancel();
    super.dispose();
  }

  void _hasFocus() {
    if (!mounted) return;
    setState(() {
      _showLoading = false;
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
  }

  void _textListener() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surface = theme.colorScheme.surface;
    final outline = theme.colorScheme.outline;
    final isLight = theme.brightness == Brightness.light;
    Widget suffix = CustomIconButton(
      onPressed: () {
        if (_focusNode.hasFocus) {
          _focusNode.unfocus();
        } else {
          _focusNode.requestFocus();
        }
      },
      icon: Icon(
        _focusNode.hasFocus ? Icons.arrow_drop_up : Icons.arrow_drop_down,
      ),
    );
    if (_controller.text.isNotEmpty) {
      suffix = CustomIconButton(
        padding: EdgeInsets.zero,
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
        ),
        onPressed: () {
          FocusScope.of(context).unfocus();
          widget.onClear?.call();
          _controller.clear();
          if (!mounted) return;
          setState(() {
            _suggestions = _allSuggestions;
          });
        },
        icon: Icon(Icons.close, color: mekongOrange(isLight)),
      );
    }
    return Column(
      key: _textKey,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextFormField(
          textInputAction: widget.textInputAction,
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
          labelText: widget.labelText,
          maxLines: 1,
          focusNode: _focusNode,
          controller: _controller,
          onChanged: _onChanged,
          onSaved: _onSaved,
          onFieldSubmitted: widget.onFieldSubmitted,
          validator:
              widget.validator ??
              (value) {
                if (_suggestions
                    .where(
                      (element) =>
                          element.text.toLowerCase() == value?.toLowerCase(),
                    )
                    .isEmpty) {
                  return '*Invalid';
                }
                widget.onSelected?.call(
                  _suggestions.firstWhere((element) => element.text == value),
                );
                return null;
              },
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              suffix,
              widget.suffixIcon,
              if (_showLoading)
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.red,
                  ),
                ),
              if (_showLoading) SizedBox(width: 8),
            ],
          ),
        ),
        if (_focusNode.hasFocus)
          Material(
            elevation: 4.0,
            color: surface,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child:
                  _suggestions.isEmpty
                      ? SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Center(
                          child: CustomText(
                            'No data',
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            fontColor: outline,
                          ),
                        ),
                      )
                      : ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        controller: _scrollController,
                        separatorBuilder:
                            (context, index) => const Divider(height: 1),
                        shrinkWrap: true,
                        itemCount: _suggestions.length,
                        itemBuilder: (context, index) {
                          final suggestion = _suggestions[index];
                          return ListTile(
                            tileColor: surface,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            title: CustomText(
                              suggestion.text,
                              fontWeight: FontWeight.bold,
                            ),
                            onTap: () {
                              _controller.text = suggestion.text;
                              if (!mounted) return;
                              FocusScope.of(context).unfocus();
                              widget.onSelected?.call(suggestion);
                            },
                          );
                        },
                      ),
            ),
          ),
      ],
    );
  }
}
