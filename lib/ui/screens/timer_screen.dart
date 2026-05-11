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
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              timerProvider.formattedTime,
              style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold, letterSpacing: 4),
            ),
            const SizedBox(height: 50),
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
            if (!timerProvider.isRunning && timerProvider.seconds > 0)
              TextButton(
                onPressed: () async {
                  // Sauvegarde de la session
                  final newSession = Session(
                    id: DateTime.now().toString(),
                    date: DateTime.now(),
                    minutes: timerProvider.seconds ~/ 60,
                    category: 'Flutter',
                  );
                  await sessionProvider.addSession(newSession);
                  timerProvider.resetTimer();
                  ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text("Session enregistrée !"),
    backgroundColor: Color(0xFF22D3EE),
    behavior: SnackBarBehavior.floating, // Pour l'effet moderne "flottant"
  ),
  );
  }
