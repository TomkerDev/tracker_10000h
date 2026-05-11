import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/session_provider.dart';
import '../widgets/progress_circle.dart';
import '../widgets/activity_chart.dart'; // N'oublie pas cet import !

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SessionProvider>();
    final totalHours = provider.totalHours;
    final progressPercent = totalHours / 10000;
    final currentLevel = provider.currentLevel;

    return Scaffold(
      body: SingleChildScrollView( // Ajouté pour éviter les erreurs de pixels si l'écran est petit
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Badge de Niveau
              Text(
                "${currentLevel.icon} ${currentLevel.label.toUpperCase()}",
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold, 
                  color: currentLevel.color,
                  letterSpacing: 2
                ),
              ),
              const SizedBox(height: 10),
              
              const Text(
                "MAÎTRISE FLUTTER",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: 4),
              ),
              const SizedBox(height: 40),
              
              // Cercle de progression
              ProgressCircle(
                progress: progressPercent,
                hours: totalHours,
              ),
              
              const SizedBox(height: 40),

              // Barre vers le prochain niveau
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: provider.levelProgress,
                      backgroundColor: Colors.white10,
                      color: currentLevel.color,
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Vers le rang ${provider.nextLevel.label}",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // --- LE GRAPHIQUE (Data Viz) ---
              const Text(
                "ACTIVITÉ (7J)", 
                style: TextStyle(fontSize: 12, color: Colors.grey, letterSpacing: 2)
              ),
              const SizedBox(height: 16),
              ActivityChart(data: provider.weeklyStats),
              
              const SizedBox(height: 40),
              
              _buildStatCard("Objectif Global", "10,000h", Icons.flag),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF22D3EE)),
          const SizedBox(width: 12),
          Text("$label : ", style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}