import 'dart:async';

class Debouncer {
  Timer? _timer;

  void start(Duration duration, Function() callback) {
    _timer?.cancel();
    _timer = Timer(duration, callback);
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }
}
