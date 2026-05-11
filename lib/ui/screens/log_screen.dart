import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; 
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
          ? const Center(
              child: Text(
                "Aucune session enregistrée", 
                style: TextStyle(color: Colors.grey)
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sessions.length, 
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
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF22D3EE).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.code, color: Color(0xFF22D3EE)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // CORRECTION : DateFormat fonctionnera après le 'flutter pub get'
                              DateFormat('dd/MM/yyyy').format(session.date),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              session.category,
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${session.seconds ~/ 60} min ${session.seconds % 60} s")
                        const SizedBox(width: 8),
IconButton(
  icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
  onPressed: () {
    // Afficher une boîte de dialogue de confirmation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Supprimer ?"),
        content: const Text("Voulez-vous vraiment effacer cette session ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("ANNULER"),
          ),
          TextButton(
            onPressed: () {
              // Appeler la suppression
              provider.deleteSession(session.id);
              Navigator.pop(context);
              
              // Petit message de confirmation
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Session supprimée")),
              );
            },
            child: const Text("SUPPRIMER", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  },
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