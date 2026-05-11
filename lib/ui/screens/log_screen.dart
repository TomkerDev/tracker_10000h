import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Pour formater les dates
import '../../logic/session_provider.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SessionProvider>();
    final sessions = provider.sessions;

    return Scaffold(
      appBar: AppBar(
        title: const Text("JOURNAL DE BORD"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: sessions.isEmpty
          ? const Center(child: Text("Aucune session enregistrée", style: TextStyle(color: Colors.grey)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sessions.size,
              itemBuilder: (context, index) {
                final session = sessions[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111827),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      // Icône ou Tag
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF22D3EE).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.code, color: Color(0xFF22D3EE)),
                      ),
                      const SizedBox(width: 16),
                      // Détails
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('dd MMMM yyyy').format(session.date),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              session.category,
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      // Durée
                      Text(
                        "${session.minutes} min",
                        style: const TextStyle(
                          color: Color(0xFF22D3EE),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}