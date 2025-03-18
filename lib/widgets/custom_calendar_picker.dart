import 'package:flutter/material.dart';

import '../extension/date_time_extension.dart';
import '../extension/string_extension.dart';
import '../resource/color.dart';
import 'custom_text_form_field.dart';

/// A custom widget for calendar picker
class CustomCalendarPicker extends StatelessWidget {
  /// Creates an instance of [CustomCalendarPicker]
  const CustomCalendarPicker({
    super.key,
    required this.firstDate,
    required this.controller,
    this.onDatePicked,
    this.hintText,
    this.endDate,
    this.validator,
    this.presentToFuture = true,
    this.autovalidateMode,
  });

  /// This is the calendar text controller
  final TextEditingController controller;

  /// This is the first date of the calendar
  final DateTime firstDate;

  /// This is the picked callback
  final void Function(DateTime?)? onDatePicked;

  /// This is the end date
  final DateTime? endDate;

  /// This is the calendar hint text
  final String? hintText;

  /// This is the calendar validation
  final String? Function(String?)? validator;

  /// This is the calendar autovalidate mode
  final AutovalidateMode? autovalidateMode;

  /// This is the condition whether users will be able to choose past date times
  final bool presentToFuture;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    return Stack(
      children: [
        CustomTextFormField(
          labelText: hintText,
          hintText: hintText,
          controller: controller,
          suffixIcon: Icon(
            Icons.calendar_month,
            color: mekongOrange(isLight),
          ),
          autovalidateMode: autovalidateMode,
          validator: validator,
        ),
        GestureDetector(
          onTap: () async {
            final initialDate = controller.text.fullDateToDateTime();

            final defaultPastDate = (initialDate ?? DateTime.now())
                .subtract(const Duration(days: 2000));

            final defaultFutureDate =
                (initialDate ?? DateTime.now()).add(const Duration(days: 2000));

            DateTime firstDate = this.firstDate;

            if (!presentToFuture) firstDate = defaultPastDate;

            final date = await showDatePicker(
              context: context,
              initialDate: initialDate ?? DateTime.now(),
              firstDate: firstDate,
              lastDate: endDate ?? defaultFutureDate,
            );
            if (date == null) return;
            onDatePicked?.call(date);
            controller.text = date.toFullDate();
          },
          child: const Opacity(
            opacity: 0,
            child: CustomTextFormField(
              enabled: false,
            ),
          ),
        ),
      ],
    );
  }
}
