// lib/models/session.dart

class Session {
  final String id;
  final DateTime date;
  final int minutes; // Stocké en minutes pour une lecture plus facile, mais on peut aussi stocker en secondes pour plus de précision
  final int seconds; // On stocke en secondes pour la précision
  final String category; // Pratique, Théorie, etc.
  final String note;

  Session({
    required this.id,
    required this.date,
    required this.seconds,
    required this.category,
    required this.minutes,
    this.note = "",
  });

  // Convertit une Session en Map (pour l'enregistrer en JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'seconds': seconds,
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
      seconds: map['seconds'],
      minutes: map['minutes'], // Utilise la valeur déjà convertie en minutes
      category: map['category'],
      note: map['note'] ?? "",
    );
  }
}