import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'logic/session_provider.dart';
import 'core/theme.dart'; // 1. Importe ton nouveau fichier de thème
import 'ui/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
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
      debugShowCheckedModeBanner: false, // Enlève la petite bannière "Debug"
      
      // 2. Applique ton thème personnalisé ici
      theme: AppTheme.darkTheme, 
      
      // 3. Définit l'écran d'accueil
      home: const HomeScreen(),
    );
  }
}