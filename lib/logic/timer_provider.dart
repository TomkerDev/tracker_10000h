import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;
  DateTime? _startTime;

  int get seconds => _seconds;
  bool get isRunning => _isRunning;

  void startTimer() {
    if (_isRunning) return;
    
    _isRunning = true;
    _startTime = DateTime.now().subtract(Duration(seconds: _seconds));
    
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_startTime != null) {
        _seconds = DateTime.now().difference(_startTime!).inSeconds;
        notifyListeners();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _isRunning = false;
    notifyListeners();
  }

  void resetTimer() {
    stopTimer();
    _seconds = 0;
    notifyListeners();
  }
  
  // Formatage propre (00:00:00)
  String get formattedTime {
    final h = _seconds ~/ 3600;
    final m = (_seconds % 3600) ~/ 60;
    final s = _seconds % 60;
    return "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }
}