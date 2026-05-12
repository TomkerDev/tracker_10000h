import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/session_provider.dart';
import '../../logic/timer_provider.dart';
import '../../logic/settings_provider.dart';
import '../widgets/progress_circle.dart';
import '../widgets/activity_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SessionProvider>();
    final timerProvider = context.watch<TimerProvider>();
    final settingsProvider = context.watch<SettingsProvider>();
    
    final totalHours = provider.totalHours;
    final progressPercent = totalHours / 10000;
    final currentLevel = provider.currentLevel;
    final activeColor = timerProvider.activeColor;

    return Scaffold(
      // AJOUT DE L'APPBAR POUR LE TOGGLE
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Icon(
            settingsProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            size: 20,
            color: Colors.grey,
          ),
          Switch(
            value: settingsProvider.isDarkMode,
            onChanged: (value) => settingsProvider.toggleTheme(value),
            activeColor: activeColor,
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),
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
                  letterSpacing: 2,
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
                      color: activeColor,
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
                style: TextStyle(fontSize: 12, color: Colors.grey, letterSpacing: 2),
              ),
              const SizedBox(height: 16),
              ActivityChart(data: provider.weeklyStats),

              const SizedBox(height: 40),

              _buildStatCard(context, "Objectif Global", "10,000h", Icons.flag),
            ],
          ),
        ),
      ),
    );
  }

  // Correction de la fonction buildStatCard pour qu'elle s'adapte au thème
  Widget _buildStatCard(BuildContext context, String label, String value, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF111827) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark ? [] : [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: context.watch<TimerProvider>().activeColor),
          const SizedBox(width: 12),
          Text("$label : ", style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}