import 'dart:async';

import 'package:flutter/material.dart';

class TimerBottomSheet extends StatefulWidget {
  @override
  _TimerBottomSheetState createState() => _TimerBottomSheetState();
}

class _TimerBottomSheetState extends State<TimerBottomSheet> {
  int _timerDuration = 60; // Initial timer duration in seconds
  late Timer _timer;
  bool isResendVisible = false;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void resendOTP() {
    // Implement your logic to resend OTP here
    // For example, you can call an API to request a new OTP
    // After requesting, reset the timer and hide the Resend button
    //AuthenticationRepository.instance.PhoneNumberAuth(user.mobile!);
    setState(() {
      _timerDuration = 60;
      isResendVisible = false;
      startTimer();
    });
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerDuration > 0) {
          _timerDuration--;
        } else {
          // Timer has reached 0, you can perform actions here
          isResendVisible = true;
          _timer.cancel(); // Stop the timer
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            isResendVisible
                ? ElevatedButton(
                    onPressed: () => resendOTP(),
                    child: const Text('Resend OTP'),
                  )
                : Text(
                    'Resend OTP after : ${_timerDuration}s',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
          ],
        ),
      ),
    );
  }
}
