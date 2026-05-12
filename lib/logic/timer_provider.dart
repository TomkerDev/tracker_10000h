import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  // --- VARIABLES DU CHRONO ---
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  // --- VARIABLES DU THEMING ---
  String _selectedCategory = "Flutter";
  
  final Map<String, Color> categoryColors = {
    "Flutter": const Color(0xFF22D3EE),
    "Dart": const Color(0xFF60A5FA),
    "Design": const Color(0xFFF97316),
    "Firebase": const Color(0xFFFBBF24),
    "Algo": const Color(0xFFA78BFA),
  };

  // --- GETTERS ---
  int get seconds => _seconds;
  bool get isRunning => _isRunning;
  String get selectedCategory => _selectedCategory;
  List<String> get categories => categoryColors.keys.toList();
  Color get activeColor => categoryColors[_selectedCategory] ?? const Color(0xFF22D3EE);

  // Formate le temps en 00:00:00
  String get formattedTime {
    final h = _seconds ~/ 3600;
    final m = (_seconds % 3600) ~/ 60;
    final s = _seconds % 60;
    return "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  // --- MÉTHODES ---

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void startTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _seconds++;
        notifyListeners();
      });
      notifyListeners();
    }
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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}