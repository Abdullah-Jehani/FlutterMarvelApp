import 'package:flutter/foundation.dart';

String fromIntToDuration(int minutes) {
  int seconds = minutes * 60;
  Duration duration = Duration(seconds: seconds);
  if (kDebugMode) {
    print(" DURATION IS $duration");
  } // Output: 2:00:00

  return duration.toString().substring(0, duration.toString().lastIndexOf(":"));
}
