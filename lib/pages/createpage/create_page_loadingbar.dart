import 'package:chuckler/CustomReusableWidgets/profile_photo.dart';
import 'package:flutter/material.dart';

class CreatePageLoadingBar extends StatefulWidget {
  const CreatePageLoadingBar({super.key});

  @override
  _CreatePageLoadingBarState createState() => _CreatePageLoadingBarState();
}

class _CreatePageLoadingBarState extends State<CreatePageLoadingBar>
    with TickerProviderStateMixin {
  var _progressValue = 0.0;
  String timeRemaining = "";
  int timeLeft = 0;

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
      timeLeft = hoursRemaining;
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
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
          flex: 5,
          child: Text(
            timeRemaining + (timeLeft > 1 ? " hours left" : " hour left"),
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: screenHeight / 70,
                fontWeight: FontWeight.w700),
          )),
      Expanded(flex: 3, child: Container()),
      Expanded(
          flex: 8,
          child: Container(
              alignment: Alignment.centerRight,
              decoration: const BoxDecoration(),
              height: 30,
              child: Row(children: [
                const ProfilePhoto(username: "Text", img: "", radius: 15),
                Text(" +100 answered",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: screenHeight / 70))
              ]))),
      /*RichText(
            textAlign: TextAlign.center,
              maxLines: 1,
              text: TextSpan(
                  children: [
            WidgetSpan(
                child: ),
            TextSpan(
                text: "+ 100 answered this",
                style: Theme.of(context).textTheme.bodySmall)
          ]))*/
    ]);
  }
}
