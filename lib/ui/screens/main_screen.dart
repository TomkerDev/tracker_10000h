import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'timer_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Liste des écrans
  final List<Widget> _screens = [
    const HomeScreen(),
    const TimerScreen(),
    const Center(child: Text("Journal (Bientôt)")), // On fera le log après
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: const Color(0xFF070D1A),
        selectedItemColor: const Color(0xFF22D3EE),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline_rounded, size: 40), label: "Timer"),
          BottomNavigationBarItem(icon: Icon(Icons.history_rounded), label: "Log"),
        ],
      ),
    );
  }
}