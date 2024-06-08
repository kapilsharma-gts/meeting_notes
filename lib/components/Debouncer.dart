import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int milliseconds;
  late VoidCallback action;
  late Timer _timer;

  Debouncer({required this.milliseconds}) {
    action = () {}; // Initializing action with an empty function
    _timer = Timer(Duration(milliseconds: milliseconds), () {});
  }

  void run(VoidCallback action) {
    _timer.cancel();
    this.action = action; // Assign the provided action
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
