import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CreatePageLoadingBar extends StatefulWidget {
  const CreatePageLoadingBar({super.key});

  @override
  _CreatePageLoadingBarState createState() => _CreatePageLoadingBarState();
}

class _CreatePageLoadingBarState extends State<CreatePageLoadingBar>
    with TickerProviderStateMixin {
  var _progressValue = 0.0;
  String timeRemaining = "";

  //Set the progress indicator
  void _updateProgress() {
    // Get current UTC time
    final now = DateTime.now().toUtc();

    // Calculate time remaining in the day (in seconds)
    final midnightUtc = DateTime.utc(now.year, now.month, now.day, 0, 0);
    final secondsRemaining = -midnightUtc.difference(now).inSeconds.toDouble();

    // Calculate progress value (percentage)
    const totalSecondsInDay = 24 * 60 * 60;
    final hoursRemaining =
        ((totalSecondsInDay - secondsRemaining) / (60 * 60)).round();
    final progressValue =
        1 - ((totalSecondsInDay - secondsRemaining) / totalSecondsInDay);

    // Update state and potentially rebuild the widget
    setState(() {
      _progressValue = progressValue;
      timeRemaining = hoursRemaining.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _updateProgress();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      AutoSizeText(
        timeRemaining + " hours remaining", style: TextStyle(color: Colors.white),
        minFontSize: 1,maxFontSize: 8,

    ),

      Container(
        margin: EdgeInsets.fromLTRB(0,0,0, 8),
          child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(10),
              value: _progressValue,
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.red)))
    ]);
  }
}
