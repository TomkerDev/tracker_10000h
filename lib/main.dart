import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import du package
import 'logic/session_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // On crée le provider et on lance l'initialisation
  final sessionProvider = SessionProvider();
  await sessionProvider.init();

  runApp(
    ChangeNotifierProvider(
      create: (context) => sessionProvider,
      child: const MyApp(),
    ),
  );
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