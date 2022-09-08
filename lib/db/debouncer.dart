// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

class Debouncer {
  var _timer;

  void run(Function callback) {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 300), (() {
      callback();
    }));
  }
}
