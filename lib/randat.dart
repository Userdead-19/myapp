import 'dart:math';
import 'dart:async';

void main() {
  DateTime starttime = DateTime(2023, 5, 27, 10, 0, 0, 0);
  DateTime endtime = DateTime(2023, 5, 27, 11, 0, 0, 0);
  DateTime randomtime = getRandomtime(starttime, endtime);
  print(randomtime);
}

DateTime getRandomtime(DateTime starttime, DateTime endtime) {
  Random random = Random();
  int min = starttime.millisecondsSinceEpoch;
  int max = endtime.millisecondsSinceEpoch;
  int randomtime = min + random.nextInt(max - min);
  DateTime randomtime1 = DateTime.fromMillisecondsSinceEpoch(randomtime);
  return randomtime1;
}

void hello() {
  // Call the randomFunctionBetweenInterval every 2 to 5 seconds
  randomFunctionCaller(Duration(seconds: 2), Duration(seconds: 5),
      randomFunctionBetweenInterval);
}

void randomFunctionCaller(
    Duration minInterval, Duration maxInterval, Function function) {
  Random random = Random();

  // Generate a random duration within the specified interval
  Duration randomDuration = minInterval +
      Duration(
          seconds:
              random.nextInt(maxInterval.inSeconds - minInterval.inSeconds));

  // Schedule the function call after the random duration
  Timer(randomDuration, () {
    function();
    // Reschedule the function call recursively
    randomFunctionCaller(minInterval, maxInterval, function);
  });
}

void randomFunctionBetweenInterval() {
  print('Random function called at ${DateTime.now()}');
}
