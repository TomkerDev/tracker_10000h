import 'package:flutter/material.dart';
import '../models/session.dart';
import '../services/storage_service.dart';

class LevelInfo {
  final String label;
  final String icon;
  final Color color;
  final int minHours;

  LevelInfo(this.label, this.icon, this.color, this.minHours);
}

class SessionProvider extends ChangeNotifier {
  // ... tes variables existantes (_sessions, _storage, etc.)

  // 1. Définition des paliers de progression
  final List<LevelInfo> levels = [
    LevelInfo("Novice", "🔰", const Color(0xFF94A3B8), 0),
    LevelInfo("Apprenti", "🔨", const Color(0xFF4ADE80), 500),
    LevelInfo("Compagnon", "⚔️", const Color(0xFF60A5FA), 1500),
    LevelInfo("Expert", "🏆", const Color(0xFFFBBF24), 3000),
    LevelInfo("Maître", "💎", const Color(0xFFF472B6), 6000),
    LevelInfo("Légende", "👑", const Color(0xFFA78BFA), 9000),
  ];

  // 2. Getter pour obtenir le niveau actuel
  LevelInfo get currentLevel {
    final hours = totalHours;
    // On parcourt la liste à l'envers pour trouver le plus haut palier atteint
    return levels.reversed.firstWhere(
      (level) => hours >= level.minHours,
      orElse: () => levels.first,
    );
  }

  // 3. Calcul du prochain palier (pour la barre de progression secondaire)
  LevelInfo get nextLevel {
    final hours = totalHours;
    return levels.firstWhere(
      (level) => level.minHours > hours,
      orElse: () => levels.last,
    );
  }

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