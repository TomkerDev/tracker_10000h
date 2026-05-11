import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/timer_provider.dart';
import '../../logic/session_provider.dart';
import '../../models/session.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch écoute les changements pour mettre à jour le texte du chrono
    final timerProvider = context.watch<TimerProvider>();
    // Read permet d'appeler une action sans reconstruire tout le widget inutilement
    final sessionProvider = context.read<SessionProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        title: const Text("CHRONO"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Affichage du temps (00:00:00)
            Text(
              timerProvider.formattedTime,
              style: const TextStyle(
                fontSize: 80, 
                fontWeight: FontWeight.bold, 
                letterSpacing: 4
              ),
            ),
            const SizedBox(height: 50),

            // Bouton Play/Pause
            GestureDetector(
              onTap: () {
                if (timerProvider.isRunning) {
                  timerProvider.stopTimer();
                } else {
                  timerProvider.startTimer();
                }
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: timerProvider.isRunning ? Colors.redAccent : const Color(0xFF22D3EE),
                  boxShadow: [
                    BoxShadow(
                      color: (timerProvider.isRunning ? Colors.redAccent : const Color(0xFF22D3EE)).withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: Icon(
                  timerProvider.isRunning ? Icons.pause : Icons.play_arrow,
                  size: 50,
                  color: Colors.black,
                ),
              ),
            ),
            
            const SizedBox(height: 40),

            // Bouton Enregistrer (n'apparaît que si le timer est arrêté et > 0)
            if (!timerProvider.isRunning && timerProvider.seconds > 0)
              TextButton(
                onPressed: () async {
                  final newSession = Session(
                    id: DateTime.now().toString(),
                    date: DateTime.now(),
                    seconds: timerProvider.seconds,
                    category: 'Flutter',
                  );

                  await sessionProvider.addSession(newSession);
                  timerProvider.resetTimer();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Session enregistrée !"),
                        backgroundColor: Color(0xFF22D3EE),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                child: const Text(
                  "ENREGISTRER LA SESSION", 
                  style: TextStyle(color: Color(0xFF22D3EE), fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}