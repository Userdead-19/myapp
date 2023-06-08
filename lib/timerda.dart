import 'dart:async';
import 'dart:math';

void main() {
  Timer.periodic(Duration(seconds: 20), (timer) {
    // Generate a random delay between 0 and 60 minutes
    print(DateTime.now());
    var random = Random();
    var delayMinutes = random.nextInt(61);

    // Schedule the function call after the random delay
    Timer(Duration(seconds: delayMinutes), () {
      // Call your function here
      myFunction();
    });

    // Stop the timer after 3 function calls
    if (timer.tick == 2) {
      timer.cancel();
    }
  });
}

void myFunction() {
  // Function body
  print(DateTime.now());
  print('Function called!');
}
