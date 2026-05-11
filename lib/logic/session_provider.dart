import 'package:flutter/material.dart';
import '../models/session.dart';
import '../services/storage_service.dart';

class SessionProvider extends ChangeNotifier {
  final StorageService _storage = StorageService();
  
  List<Session> _sessions = [];
  bool _isLoading = true;

  // Getters pour accéder aux données depuis l'UI
  List<Session> get sessions => _sessions;
  bool get isLoading => _isLoading;

  // Calcul du total d'heures (La fameuse progression vers 10 000)
  double get totalHours {
    int totalMinutes = 0;
    for (var session in _sessions) {
      totalMinutes += session.minutes;
    }
    return totalMinutes / 60;
  }

  // Initialisation : Charger les données au lancement
  Future<void> init() async {
    _sessions = await _storage.loadSessions();
    _isLoading = false;
    notifyListeners(); // Prévient l'UI qu'il faut se rafraîchir
  }

  // Ajouter une session
  Future<void> addSession(Session session) async {
    _sessions.insert(0, session); // Ajoute au début de la liste
    notifyListeners();
    await _storage.saveSessions(_sessions); // Sauvegarde persistante
  }
}