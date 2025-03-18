import 'package:flutter/material.dart';

import 'custom_card.dart';

/// A custom widget for [showModalBottomSheet] with handle
class CustomBottomSheetBody extends StatelessWidget {
  /// Creates an instance of [CustomBottomSheetBody]
  const CustomBottomSheetBody({
    super.key,
    this.title,
    this.withCard = true,
    this.actionsMainAxisAlignment = MainAxisAlignment.end,
    this.actions = const [],
    required this.child,
  });

  /// This is the custom optional title of the sheet
  final Widget? title;

  /// This is the custom child of the sheet
  final Widget child;

  /// This is condition to put child inside a card or not
  final bool withCard;

  /// This is the alignment of the actions
  final MainAxisAlignment actionsMainAxisAlignment;

  /// This is the actions of the sheet
  final List<Widget> actions;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surface = theme.colorScheme.surface;
    final scrollController = ScrollController();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(maxHeight: constraints.maxHeight * 0.9),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 8.0,
                  width: 40.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              if (title != null)
                Padding(padding: const EdgeInsets.all(8.0), child: title!),
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: scrollController,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    controller: scrollController,
                    shrinkWrap: true,
                    children: [
                      if (withCard)
                        CustomCard(
                          contentPadding: const EdgeInsets.all(8),
                          child: child,
                        ),
                      if (!withCard) child,
                    ],
                  ),
                ),
              ),
              // actions
              SafeArea(
                child: Row(
                  mainAxisAlignment: actionsMainAxisAlignment,
                  children: actions,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
