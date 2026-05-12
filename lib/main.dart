import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'logic/session_provider.dart';
import 'ui/screens/main_screen.dart';
import 'logic/timer_provider.dart';
import 'logic/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final sessionProvider = SessionProvider();
  await sessionProvider.init();

 runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SessionProvider()..init()),
        ChangeNotifierProvider(create: (_) => TimerProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
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
      // 1. THÈME CLAIR (Automatique)
  theme: ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF8FAFC), // Fond clair moderne
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF22D3EE),
      brightness: Brightness.light,
    ),
  ),

  // 2. THÈME SOMBRE (Ton style actuel)
  darkTheme: ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF030712), // Ton fond actuel
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF22D3EE),
      brightness: Brightness.dark,
    ),
  ),

  // 3. MODE AUTOMATIQUE
  themeMode: ThemeMode.system,
      
      // 3. Définit l'écran d'accueil
      home: const MainScreen(),
    );
  }
}