import 'package:flutter/material.dart';

import '../extension/date_time_extension.dart';
import '../extension/string_extension.dart';
import '../resource/text_style.dart';
import 'custom_text_form_field.dart';

/// A custom widget for calendar picker
class CustomCalendarPicker extends StatelessWidget {
  /// Creates an instance of [CustomCalendarPicker]
  const CustomCalendarPicker({
    super.key,
    required this.controller,
    this.hintText,
    this.endDate,
    this.initialDateController,
    this.validator,
    this.presentToFuture = true,
    required this.onDatePicked,
    this.dayPad = 0,
    this.prefix,
  });

  /// This is the calendar text controller
  final TextEditingController controller;

  /// This is the end date
  final DateTime? endDate;

  /// This is the initial date
  final TextEditingController? initialDateController;

  /// This is the calendar hint text
  final String? hintText;

  /// This is the calendar validation
  final String? Function(String?)? validator;

  /// This is the calendar picked function
  final void Function(DateTime) onDatePicked;

  /// This is the condition whether users will be able to choose past date times
  final bool presentToFuture;

  /// This is to pad the past date
  final int dayPad;

  /// This is the prefix widget
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inverseSurface = theme.colorScheme.inverseSurface;
    final defaultPrefixIconColor = theme.colorScheme.onSurface;
    return GestureDetector(
      onTap: () async {
        final controllerDate = controller.text.fullDateToDateTime();

        final defaultPastDate = (controllerDate ?? DateTime.now()).subtract(
          const Duration(days: 2000),
        );

        final defaultFutureDate = (controllerDate ?? DateTime.now()).add(
          const Duration(days: 2000),
        );

        DateTime firstDate = controllerDate ?? defaultPastDate;

        if (!presentToFuture) firstDate = defaultPastDate;
        final initialDate = initialDateController?.text.fullDateToDateTime();
        if (initialDate != null) firstDate = initialDate;
        firstDate = firstDate.add(Duration(days: dayPad));
        final date = await showDatePicker(
          builder: (context, child) {
            final theme = Theme.of(context);
            final surfaceTint = theme.colorScheme.surfaceTint;
            return Theme(
              data: Theme.of(context).copyWith(
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    textStyle: customTextStyle(theme),
                    foregroundColor: surfaceTint,
                  ),
                ),
              ),
              child: child!,
            );
          },
          context: context,
          initialDate: controllerDate ?? DateTime.now(),
          firstDate: firstDate,
          lastDate: endDate ?? defaultFutureDate,
        );
        if (date == null) return;
        controller.text = date.toFullDate();
        onDatePicked(date);
      },
      child: CustomTextFormField(
        prefixIcon: prefix,
        prefixIconColor: defaultPrefixIconColor,
        suffixIconColor: defaultPrefixIconColor,
        labelText: hintText,
        hintText: hintText,
        enabled: false,
        controller: controller,
        suffixIcon: const Icon(Icons.calendar_month),
        validator: validator,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: inverseSurface),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}
