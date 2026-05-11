import 'package:flutter/material.dart';
import '../models/session.dart';
import '../services/storage_service.dart';

// 1. Définition de la structure d'un Niveau
class LevelInfo {
  final String label;
  final String icon;
  final Color color;
  final int minHours;

  LevelInfo(this.label, this.icon, this.color, this.minHours);
}

// 2. Le Cerveau de l'application
class SessionProvider extends ChangeNotifier {
  final StorageService _storage = StorageService();
  
  List<Session> _sessions = [];
  bool _isLoading = true;

  // Définition des paliers
  final List<LevelInfo> levels = [
    LevelInfo("Novice", "🔰", const Color(0xFF94A3B8), 0),
    LevelInfo("Apprenti", "🔨", const Color(0xFF4ADE80), 500),
    LevelInfo("Compagnon", "⚔️", const Color(0xFF60A5FA), 1500),
    LevelInfo("Expert", "🏆", const Color(0xFFFBBF24), 3000),
    LevelInfo("Maître", "💎", const Color(0xFFF472B6), 6000),
    LevelInfo("Légende", "👑", const Color(0xFFA78BFA), 9000),
  ];

  // Getters
  List<Session> get sessions => _sessions;
  bool get isLoading => _isLoading;

  // Calcul du total d'heures
  double get totalHours {
    int totalMinutes = 0;
    for (var session in _sessions) {
      totalMinutes += session.seconds ~/ 60; // Convertir les secondes en minutes
    }
    return totalMinutes / 60;
  }

  // Logique du niveau actuel
  LevelInfo get currentLevel {
    final hours = totalHours;
    return levels.reversed.firstWhere(
      (level) => hours >= level.minHours,
      orElse: () => levels.first,
    );
  }

  // Logique du prochain niveau
  LevelInfo get nextLevel {
    final hours = totalHours;
    return levels.firstWhere(
      (level) => level.minHours > hours,
      orElse: () => levels.last,
    );
  }

  // Initialisation (Chargement depuis le téléphone)
  Future<void> init() async {
    _sessions = await _storage.loadSessions();
    _isLoading = false;
    notifyListeners();
  }

  // Ajouter une session et sauvegarder
  Future<void> addSession(Session session) async {
    _sessions.insert(0, session); 
    notifyListeners();
    await _storage.saveSessions(_sessions);
  }
  // Dans SessionProvider
double get levelProgress {
  final current = currentLevel;
  final next = nextLevel;
  
  if (current == next) return 1.0; // Niveau max atteint (Légende)
  
  final range = next.minHours - current.minHours;
  final progressInLevel = totalHours - current.minHours;
  
  return (progressInLevel / range).clamp(0.0, 1.0);
}
// Dans lib/logic/session_provider.dart

Future<void> deleteSession(String id) async {
  // 1. Retirer la session de la liste en mémoire
  _sessions.removeWhere((session) => session.id == id);
  
  // 2. Prévenir l'UI de se rafraîchir
  notifyListeners();
  
  // 3. Sauvegarder la nouvelle liste (sans la session supprimée) sur le disque
  await _storage.saveSessions(_sessions);
}

// Récupère les totaux des 7 derniers jours
Map<int, double> get weeklyStats {
  Map<int, double> stats = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0};
  
  DateTime now = DateTime.now();
  // On ne garde que les sessions des 7 derniers jours
  for (var session in _sessions) {
    if (now.difference(session.date).inDays < 7) {
      int weekday = session.date.weekday; // 1 = Lundi, 7 = Dimanche
      stats[weekday] = (stats[weekday] ?? 0) + (session.seconds / 3600);
    }
  }
  return stats;
}
}