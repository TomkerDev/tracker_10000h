import 'dart:math';
import 'package:flutter/material.dart';

class ProgressCircle extends StatelessWidget {
  final double progress; // entre 0.0 et 1.0
  final double hours;

  const ProgressCircle({super.key, required this.progress, required this.hours});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(250, 250),
          painter: CirclePainter(progress: progress),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${hours.toInt()}",
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white),
            ),
            const Text("HEURES", style: TextStyle(letterSpacing: 2, fontSize: 14, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}

class CirclePainter extends CustomPainter {
  final double progress;
  CirclePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final strokeWidth = 15.0;

    // 1. Cercle de fond (gris sombre)
    final backgroundPaint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, backgroundPaint);

    // 2. Arc de progression (Dégradé Cyan)
    final progressPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF22D3EE), Color(0xFF818CF8)],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Commence en haut
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}