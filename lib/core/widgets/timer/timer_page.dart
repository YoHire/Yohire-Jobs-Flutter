import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/widgets/timer/bloc/timer_bloc.dart';

class CustomTimer extends StatefulWidget {
  final int duration;
  const CustomTimer({super.key, required this.duration});

  @override
  State<CustomTimer> createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  int value = 0;
  @override
  void initState() {
    super.initState();
    value = widget.duration;
    _startTimer();
  }

  void _startTimer() async {
    context.read<TimerBloc>().add(TimerStarted());
    for (int i = 0; i < widget.duration; i++) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        value--;
      });
    }
    context.read<TimerBloc>().add(TimerStopped());
  }

  @override
  Widget build(BuildContext context) {
    return Text(value.toString());
  }
}
