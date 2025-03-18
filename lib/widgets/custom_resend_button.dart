import 'dart:async';

import 'package:flutter/material.dart';

import 'custom_elevated_button.dart';
import 'custom_text.dart';
import 'custom_text_loading.dart';

/// A custom timer widget for showing elapsed time
class CustomResendButton extends StatefulWidget {
  /// Creates an instance of [CustomResendButton]
  const CustomResendButton({super.key, this.onResend});

  /// This is the resend callback
  final void Function()? onResend;

  @override
  State<CustomResendButton> createState() => _CustomResendButtonState();
}

class _CustomResendButtonState extends State<CustomResendButton> {
  Timer? timer;
  String result = '';
  int resendTimeOut = 60;
  int resendTimer = 0;
  int _retryCount = 0;
  @override
  void initState() {
    resendTimer = resendTimeOut;
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    timer ??= Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (resendTimer == 0) {
        timer?.cancel();
        timer = null;
      } else {
        resendTimer--;
      }
      if (result == '0' && resendTimer == 0) return;
      setState(() {
        result = '$resendTimer';
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final timerDone = resendTimer == 0;
    if (result.isEmpty) result = '$resendTimer';
    if (result == '0' && resendTimer != 0) result = '$resendTimer';
    Widget child = Row(
      children: [
        const CustomTextLoading(),
        const SizedBox(width: 8),
        CustomText(result, fontColor: Colors.white),
      ],
    );
    if (timerDone) {
      child = CustomText(
        'Resend',
        fontColor: Colors.white,
        fontWeight: FontWeight.bold,
      );
    }

    return CustomElevatedButton(
      onPressed:
          timerDone
              ? () {
                _retryCount++;
                setState(() {
                  resendTimer = resendTimeOut * _retryCount;
                });
                _startTimer();
                widget.onResend?.call();
              }
              : null,
      child: child,
    );
  }
}
