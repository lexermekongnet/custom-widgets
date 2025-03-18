import 'package:flutter/material.dart';

/// A custom widget of [CircularProgressIndicator]
class CustomTextLoading extends StatelessWidget {
  /// Creates an instance of [CustomTextLoading]
  const CustomTextLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 16,
      height: 16,
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2,
      ),
    );
  }
}
