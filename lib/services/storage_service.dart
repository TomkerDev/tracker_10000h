// lib/services/storage_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/session.dart';

class StorageService {
  static const String _key = 'user_sessions';

  // Sauvegarder la liste complète des sessions
  Future<void> saveSessions(List<Session> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    // On transforme la liste d'objets en une grande chaîne de caractères JSON
    final String encodedData = json.encode(
      sessions.map((s) => s.toMap()).toList(),
    );
    await prefs.setString(_key, encodedData);
  }

  // Charger les sessions sauvegardées
  Future<List<Session>> loadSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? sessionsString = prefs.getString(_key);
    
    if (sessionsString == null) return [];

    final List<dynamic> decodedData = json.decode(sessionsString);
    return decodedData.map((item) => Session.fromMap(item)).toList();
  }
}