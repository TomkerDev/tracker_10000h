// lib/models/session.dart

class Session {
  final String id;
  final DateTime date;
  final int seconds; // On stocke en secondes pour la précision
  final String category; // Pratique, Théorie, etc.
  final String note;

  Session({
    required this.id,
    required this.date,
    required this.seconds,
    required this.category,
    this.note = "",
  });

  // Convertit une Session en Map (pour l'enregistrer en JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'seconds': seconds,
      'category': category,
      'note': note,
    };
  }

  // Crée une Session à partir d'une Map (quand on lit le fichier)
  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'],
      date: DateTime.parse(map['date']),
      seconds: map['seconds'],
      category: map['category'],
      note: map['note'] ?? "",
    );
  }
}