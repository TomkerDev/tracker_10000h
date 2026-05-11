// lib/models/session.dart

class Session {
  final String id;
  final DateTime date;
  final int minutes; // On stocke en minutes pour la précision
  final String category; // Pratique, Théorie, etc.
  final String note;

  Session({
    required this.id,
    required this.date,
    required this.minutes,
    required this.category,
    this.note = "",
  });

  // Convertit une Session en Map (pour l'enregistrer en JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'minutes': minutes,
      'category': category,
      'note': note,
    };
  }

  // Crée une Session à partir d'une Map (quand on lit le fichier)
  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'],
      date: DateTime.parse(map['date']),
      minutes: map['minutes'],
      category: map['category'],
      note: map['note'] ?? "",
    );
  }
}