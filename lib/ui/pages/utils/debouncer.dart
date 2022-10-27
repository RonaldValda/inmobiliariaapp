import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer{
  Timer? timer;

  void execute(VoidCallback action,int seconds){
    timer?.cancel();
    timer=Timer(Duration(seconds: seconds), action);
  }
}