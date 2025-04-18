import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

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
  final _showLoadingController = ValueNotifier(false);
  final _hasFocusController = ValueNotifier(false);
  final ValueNotifier<List<({String text, dynamic value})>>
  _suggestionController = ValueNotifier([]);
  List<({String text, dynamic value})> _allSuggestion = [];
  Timer? _debouncer;

  /// Add new data
  void add(List<({String text, dynamic value})> data) {
    _allSuggestion = data;
    _suggestionController.value = data;
    final suggestion = _getSuggestion(_controller.text);
    if (suggestion == null) return;
    _controller.text = suggestion.text;
    widget.onSelected?.call(suggestion);
  }

  /// Add show loading
  void loading(bool isLoading) => _showLoadingController.value = isLoading;

  /// Initialize
  void initial(({String text, dynamic value}) data) {
    _controller.text = data.text;
    final list = List<({String text, dynamic value})>.from([
      data,
      ..._suggestionController.value,
    ]);
    _suggestionController.value = list;
    widget.onSelected?.call(data);
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
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
    _suggestionController.value =
        _allSuggestion
            .where(
              (item) => item.text.toLowerCase().contains(value.toLowerCase()),
            )
            .toList();

    return _suggestionController.value.firstWhereOrNull(
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
    _scrollController.removeListener(_onScroll);
    _focusNode.dispose();
    _scrollController.dispose();
    if (widget.controller == null) _controller.dispose();
    _debouncer?.cancel();
    _showLoadingController.dispose();
    _suggestionController.dispose();
    _hasFocusController.dispose();
    super.dispose();
  }

  void _hasFocus() {
    _showLoadingController.value = false;
    _hasFocusController.value = _focusNode.hasFocus;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_textKey.currentContext != null) {
        Scrollable.ensureVisible(
          _textKey.currentContext!,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surface = theme.colorScheme.surface;
    final outline = theme.colorScheme.outline;

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
                if (_suggestionController.value
                    .where(
                      (element) =>
                          element.text.toLowerCase() == value?.toLowerCase(),
                    )
                    .isEmpty) {
                  return '*Invalid';
                }
                widget.onSelected?.call(
                  _suggestionController.value.firstWhere(
                    (element) => element.text == value,
                  ),
                );
                return null;
              },
          suffixIcon: ValueListenableBuilder(
            valueListenable: _showLoadingController,
            builder: (context, loading, child) {
              Widget suffix = ValueListenableBuilder(
                valueListenable: _hasFocusController,
                builder: (context, hasFocus, child) {
                  return CustomIconButton(
                    onPressed: () {
                      if (_focusNode.hasFocus) {
                        _hasFocusController.value = false;
                        _focusNode.unfocus();
                      } else {
                        _hasFocusController.value = true;
                        _focusNode.requestFocus();
                      }
                    },
                    icon: Icon(
                      hasFocus ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    ),
                  );
                },
              );
              if (_controller.text.isNotEmpty) {
                suffix = CustomIconButton(
                  padding: EdgeInsets.zero,
                  visualDensity: const VisualDensity(
                    vertical: VisualDensity.minimumDensity,
                    horizontal: VisualDensity.minimumDensity,
                  ),
                  icon: Icon(Icons.clear, color: Colors.red),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    widget.onClear?.call();
                    _controller.clear();
                    _suggestionController.value = _allSuggestion;
                  },
                );
              }
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  suffix,
                  widget.suffixIcon,
                  if (loading)
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.red,
                      ),
                    ),
                  if (loading) SizedBox(width: 8),
                ],
              );
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: _hasFocusController,
          builder: (context, hasFocus, child) {
            if (!hasFocus) return const SizedBox.shrink();
            return Material(
              elevation: 4.0,
              color: surface,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ValueListenableBuilder(
                  valueListenable: _suggestionController,
                  builder: (context, suggestions, child) {
                    if (suggestions.isEmpty) {
                      return SizedBox(
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
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      controller: _scrollController,
                      separatorBuilder:
                          (context, index) => const Divider(height: 1),
                      shrinkWrap: true,
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion = suggestions[index];
                        return ListTile(
                          tileColor: surface,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          title: CustomText(
                            suggestion.text.trim(),
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
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
