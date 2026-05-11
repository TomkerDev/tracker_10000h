import 'package:flutter/material.dart';
import 'services/storage_service.dart';
import 'models/session.dart';

void main() async {
  // 1. Indispensable pour utiliser les services natifs (comme le stockage) avant runApp
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Instanciation du service
  final storage = StorageService();

  // 3. Petit test : Création d'une session fictive
  final testSession = Session(
    id: '1',
    date: DateTime.now(),
    minutes: 45,
    category: 'Pratique',
    note: 'Premier test de stockage',
  );

  // 4. On essaie de sauvegarder puis de relire
  print("--- Début du test de stockage ---");
  await storage.saveSessions([testSession]);
  
  final sessionsChargees = await storage.loadSessions();
  print("Sessions chargées : ${sessionsChargees.length}");
  if (sessionsChargees.isNotEmpty) {
    print("Dernière session : ${sessionsChargees.first.note} (${sessionsChargees.first.minutes} min)");
  }
  print("--- Test réussi ! ---");

  // 5. On lance l'application normalement
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10000h Tracker',
      theme: ThemeData(
        brightness: Brightness.dark, // On garde l'esprit Dark Mode
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: Center(child: Text('Backend Initialisé !')),
      ),
    );
  }
}