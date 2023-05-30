import 'package:flutter/material.dart';
import 'package:nobook/src/utils/utils_barrel.dart' show UtilFunctions;

class TimerWidget extends StatelessWidget {
  final Stream<Duration> timer;
  final Duration timerDuration;
  final TextStyle textStyle;
  final String leadingText;
  final WidgetBuilder? onComplete;

  const TimerWidget({
    Key? key,
    required this.timer,
    required this.textStyle,
    required this.timerDuration,
    required this.leadingText,
    this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: timer,
      initialData: timerDuration,
      builder: (context, snapshot) {
        if (snapshot.data == Duration.zero) {
          return onComplete?.call(context) ??
              Text(
                UtilFunctions.formatMinutesDuration(Duration.zero),
                style: textStyle,
              );
        }
        final Duration data = snapshot.requireData;
        return Wrap(
          children: [
            Text(
              UtilFunctions.formatMinutesDuration(data),
              style: textStyle,
            ),
          ],
        );
      },
    );
  }
}
