import 'dart:async';

import 'package:flutter/material.dart';

import '../resource/color.dart';
import 'custom_list_tile.dart';
import 'custom_text.dart';
import 'custom_text_form_field.dart';

/// A custom widget class for auto complete wi
class CustomAutocompleteNew extends StatefulWidget {
  /// Creates an instance of [CustomAutocompleteNew]
  const CustomAutocompleteNew({
    super.key,
    this.enabled,
    this.onSelected,
    this.labelText,
    this.hintText,
    this.validator,
    this.optionsViewOpenDirection = OptionsViewOpenDirection.down,
    this.onSaved,
    this.onClear,
    this.onChange,
    this.onLoadMore,
    this.onAutoCompleteBuild,
    this.prefixIcon,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  /// This is the autocomplete label text
  final String? labelText;

  /// This is the autocomplete hint text
  final String? hintText;

  /// This is the select dropdown callback
  final void Function(({String text, String value}))? onSelected;

  /// This is the validator callback
  final String? Function(String?)? validator;

  /// This is the direction of the autocomplete body
  final OptionsViewOpenDirection optionsViewOpenDirection;

  /// This is enable condition
  final bool? enabled;

  /// This is the onSaved callback
  final void Function(String)? onSaved;

  /// This is the onSaved callback
  final void Function()? onClear;

  /// This is the on load more callback
  final void Function()? onLoadMore;

  /// This is the onAutoComplete built
  final void Function(TextEditingController)? onAutoCompleteBuild;

  /// This is the onChange callback
  final void Function(String)? onChange;

  /// This is the icon on the left
  final Widget? prefixIcon;

  /// This is the optional input action
  final TextInputAction? textInputAction;

  /// This is the onChange callback
  final void Function(String)? onFieldSubmitted;

  @override
  CustomAutocompleteNewState createState() => CustomAutocompleteNewState();
}

/// A state class of [CustomAutocompleteNew]
class CustomAutocompleteNewState extends State<CustomAutocompleteNew> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _materialKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();
  List<({String text, String value})> _suggestions = [];
  List<({String text, String value})> _allSuggestions = [];
  Timer? _debouncer;

  bool _showSuggestions = false;
  bool _showLoading = false;
  ({String text, String value})? _selected;
  bool _isFirstAdd = true;

  /// Add new data
  void add(List<({String text, String value})> data) {
    if (!mounted) return;
    setState(() {
      _allSuggestions = data;
      _suggestions = data;
      _showSuggestions = _selected == null && !_isFirstAdd;
    });
    _isFirstAdd = false;
  }

  /// Add show loading
  void loading(bool isLoading) {
    if (!mounted) return;
    setState(() => _showLoading = isLoading);
  }

  @override
  void initState() {
    _focusNode.addListener(_hasFocus);
    _scrollController.addListener(_onScroll);
    widget.onAutoCompleteBuild?.call(_controller);
    super.initState();
  }

  void _onChanged(String value) {
    setState(() {
      _suggestions =
          _allSuggestions
              .where(
                (item) => item.text.toLowerCase().contains(value.toLowerCase()),
              )
              .toList();
      _showSuggestions = value.isNotEmpty && _suggestions.isNotEmpty;
    });
    widget.onChange?.call(value);
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
    _controller.dispose();
    _debouncer?.cancel();
    super.dispose();
  }

  void _hasFocus() {
    if (!mounted) return;
    setState(() {
      _showSuggestions = _focusNode.hasFocus && _suggestions.isNotEmpty;
      _showLoading = false;
      if (_showSuggestions == true) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_materialKey.currentContext != null) {
            Scrollable.ensureVisible(
              _materialKey.currentContext!,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        });
      }
    });
  }

  bool _suffixVisible = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surface = theme.colorScheme.surface;
    final outline = theme.colorScheme.outline;
    final isLight = theme.brightness == Brightness.light;
    _suffixVisible = _controller.text.isNotEmpty;
    return Column(
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
                  return '*Required';
                }
                return null;
              },
          suffixIcon: Visibility(
            visible: _suffixVisible,
            child: IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                widget.onClear?.call();
                _controller.clear();
                if (!mounted) return;
                setState(() {
                  _suffixVisible = true;
                  _suggestions = _allSuggestions;
                });
                _selected = null;
              },
              icon: Icon(Icons.clear, color: mekongOrange(isLight)),
            ),
          ),
        ),
        if (_showSuggestions)
          Material(
            key: _materialKey,
            elevation: 4.0,
            color: surface,
            child: SizedBox(
              height: _suggestions.isEmpty ? 50 : 200,
              child:
                  _suggestions.isEmpty
                      ? Center(
                        child: CustomText(
                          'No data',
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontColor: outline,
                        ),
                      )
                      : ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        controller: _scrollController,
                        separatorBuilder:
                            (context, index) => const Divider(height: 1),
                        shrinkWrap: true,
                        itemCount:
                            _showLoading
                                ? _suggestions.length + 1
                                : _suggestions.length,
                        itemBuilder: (context, index) {
                          if (index == _suggestions.length) {
                            if (!_showLoading) return Container();
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                            );
                          }
                          final suggestion = _suggestions[index];
                          return CustomListTile(
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
                              setState(() {
                                _showSuggestions = false;
                              });
                              FocusScope.of(context).unfocus();
                              widget.onSelected?.call(suggestion);
                              _selected = suggestion;
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
