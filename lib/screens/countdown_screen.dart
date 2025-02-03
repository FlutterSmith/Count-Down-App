import 'dart:async';
import 'package:flutter/material.dart';
import '../models/event.dart';

class CountdownScreen extends StatefulWidget {
  final Event event;

  CountdownScreen({required this.event});

  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  late Timer _timer;
  Duration _timeLeft = Duration();

  void _calculateTimeLeft() {
    final now = DateTime.now();
    setState(() {
      _timeLeft = widget.event.eventDate.difference(now);
    });
  }

  @override
  void initState() {
    super.initState();
    _calculateTimeLeft();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _calculateTimeLeft();
      if (_timeLeft.isNegative) {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    if (duration.isNegative) return "Event Passed";
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return '$days days, $hours hours, $minutes minutes, $seconds seconds';
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = widget.event.colorHex != null
        ? Color(int.parse(widget.event.colorHex!.replaceAll('#', '0xff')))
        : Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
        backgroundColor: themeColor,
      ),
      body: Container(
        decoration: widget.event.backgroundImagePath != null
            ? BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.event.backgroundImagePath!),
                  fit: BoxFit.cover,
                ),
              )
            : null,
        child: Center(
          child: Text(
            _formatDuration(_timeLeft),
            style: TextStyle(fontSize: 32, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
