import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ActivityChart extends StatelessWidget {
  final Map<int, double> data;
  const ActivityChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _getMaxY(), // Calcule la hauteur max automatiquement
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const days = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];
                  return Text(days[value.toInt() - 1], 
                    style: const TextStyle(color: Colors.grey, fontSize: 12));
                },
              ),
            ),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: data.entries.map((e) => BarChartGroupData(
            x: e.key,
            barRods: [
              BarChartRodData(
                toY: e.value,
                color: const Color(0xFF22D3EE),
                width: 12,
                borderRadius: BorderRadius.circular(4),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: _getMaxY(),
                  color: Colors.white10,
                ),
              ),
            ],
          )).toList(),
        ),
      ),
    );
  }

  double _getMaxY() {
    double max = 0;
    data.forEach((k, v) { if (v > max) max = v; });
    return max == 0 ? 5 : max + 1; // Minimum 5h d'échelle
  }
}