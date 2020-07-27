import 'dart:async';
import 'package:flutter/widgets.dart';

/// Displays a countdown with the ability to start, pause and reset.
class CustomCountdown extends StatefulWidget {
  // Length of the timer
  final int seconds;

  // Build method for the timer
  final Widget Function(BuildContext, int) build;

  // Called when timer is finished
  final Function onFinished;

  // Build interval
  final Duration interval;

  // Controller
  final CountdownController controller;

  // Whether to start the timer immediately or not
  final bool startImmediately;

  CustomCountdown({
    Key key,
    @required this.seconds,
    @required this.build,
    this.interval = const Duration(seconds: 1),
    this.onFinished,
    this.controller,
    this.startImmediately = true,
  }) : super(key: key);

  static String prettify(Duration duration) {
    String hours = duration.inHours.remainder(60).toString();
    String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, "0");
    String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, "0");

    String result = "";
    if (hours != "0") {
      result += "$hours:";
    }

    result += "$minutes:$seconds";

    return result;
  }

  @override
  _CustomCountdownState createState() => _CustomCountdownState();
}

class _CustomCountdownState extends State<CustomCountdown> {
  // Multiplier of seconds
  final int _secondsFactor = 1000000;

  Timer _timer;

  int _currentMicroSeconds;

  @override
  void initState() {
    _currentMicroSeconds = widget.seconds * _secondsFactor;

    widget.controller?.setOnPause(_onTimerPaused);
    widget.controller?.setOnResume(_onTimerResumed);
    widget.controller?.setOnRestart(_onTimerRestart);
    widget.controller?.isCompleted = false;

    if (widget.startImmediately) {
      _startTimer();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(
      context,
      _currentMicroSeconds ~/ _secondsFactor,
    );
  }

  @override
  void dispose() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }

    super.dispose();
  }

  void _onTimerPaused() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
  }

  void _onTimerResumed() {
    _startTimer();
  }

  void _onTimerRestart() {
    widget.controller?.isCompleted = false;

    setState(() {
      _currentMicroSeconds = widget.seconds * _secondsFactor;
    });

    _startTimer();
  }

  void _startTimer() {
    if (_timer?.isActive == true) {
      _timer.cancel();

      widget.controller?.isCompleted = true;
    }

    if (_currentMicroSeconds != 0) {
      _timer = Timer.periodic(
        widget.interval,
            (Timer timer) {
          if (_currentMicroSeconds == 0) {
            timer.cancel();

            if (widget.onFinished != null) {
              widget.onFinished();
            }

            widget.controller?.isCompleted = true;
          } else {
            setState(() {
              _currentMicroSeconds =
                  _currentMicroSeconds - widget.interval.inMicroseconds;
            });
          }
        },
      );
    }
  }
}

/// Controller for Countdown
class CountdownController {
  // Called when called `pause` method
  VoidCallback onPause;

  // Called when called `resume` method
  VoidCallback onResume;

  // Called when restarting the timer
  VoidCallback onRestart;

  ///
  /// Checks if the timer is running and enables you to take actions according to that.
  /// if the timer is still active, `isCompleted` returns `false` and vice versa.
  ///
  /// for example:
  ///
  ///   _controller.isCompleted ? _controller.restart() : _controller.pause();
  ///
  bool isCompleted;

  ///
  /// Constructor
  ///
  CountdownController();

  ///
  /// Set timer in pause
  ///
  pause() {
    if (this.onPause != null) {
      this.onPause();
    }
  }

  setOnPause(VoidCallback onPause) {
    this.onPause = onPause;
  }

  ///
  /// Resume from pause
  ///
  resume() {
    if (this.onResume != null) {
      this.onResume();
    }
  }

  setOnResume(VoidCallback onResume) {
    this.onResume = onResume;
  }

  ///
  /// Restart timer from cold
  ///
  restart() {
    if (this.onRestart != null) {
      this.onRestart();
    }
  }

  setOnRestart(VoidCallback onRestart) {
    this.onRestart = onRestart;
  }
}

