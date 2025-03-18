import 'package:flutter/material.dart';

import 'custom_card.dart';

/// A custom widget for [showModalBottomSheet] with handle
class CustomBottomSheetBody extends StatelessWidget {
  /// Creates an instance of [CustomBottomSheetBody]
  const CustomBottomSheetBody({
    super.key,
    required this.child,
    this.withCard = true,
  });

  /// This is the custom child of the sheet
  final Widget child;

  /// This is condition to put child inside a card or not
  final bool withCard;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surface = theme.colorScheme.surface;
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          if (withCard)
            CustomCard(contentPadding: const EdgeInsets.all(8), child: child),
          if (!withCard) child,
        ],
      ),
    );
  }
}
