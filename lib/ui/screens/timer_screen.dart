import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/timer_provider.dart';
import '../../logic/session_provider.dart';
import '../../models/session.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final timerProvider = context.watch<TimerProvider>();
    final sessionProvider = context.read<SessionProvider>();

    return Scaffold(
      appBar: AppBar(
        // CORRECTION : Utilisation de paramètres nommés uniquement
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("CHRONO"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- LE SÉLECTEUR DE CATÉGORIES ---
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: timerProvider.categories.map((cat) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: timerProvider.selectedCategory == cat,
                      onSelected: (selected) {
                        if (selected) timerProvider.setCategory(cat);
                      },
                      selectedColor: const Color(0xFF22D3EE),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            const SizedBox(height: 50),

            // Affichage du temps
            Text(
              timerProvider.formattedTime,
              style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 50),

            // Bouton Play/Pause
            GestureDetector(
              onTap: () => timerProvider.isRunning 
                  ? timerProvider.stopTimer() 
                  : timerProvider.startTimer(),
              child: Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: timerProvider.isRunning ? Colors.redAccent : const Color(0xFF22D3EE),
                ),
                child: Icon(timerProvider.isRunning ? Icons.pause : Icons.play_arrow, size: 50),
              ),
            ),

            const SizedBox(height: 40),

            // Bouton Enregistrer
            if (!timerProvider.isRunning && timerProvider.seconds > 0)
              TextButton(
                onPressed: () async {
                  // CORRECTION : On s'assure que le nom du paramètre correspond au modèle
                  final newSession = Session(
                    id: DateTime.now().toString(),
                    date: DateTime.now(),
                    seconds: timerProvider.seconds,
                    minutes: (timerProvider.seconds / 60).ceil(),
                    category: timerProvider.selectedCategory,
                  );

                  await sessionProvider.addSession(newSession);
                  timerProvider.resetTimer();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Session enregistrée !")),
                    );
                  }
                },
                child: const Text("ENREGISTRER LA SESSION"),
              ),
          ],
        ),
      ),
    );
  }
}