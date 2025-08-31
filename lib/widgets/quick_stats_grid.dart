import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class QuickStatsGrid extends StatelessWidget {
  const QuickStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
        children: const [
          _StatCard(
            icon: Icons.access_time,
            label: 'Horas Hoje',
            value: '7h 30m',
            color: AppColors.primary,
          ),
          _StatCard(
            icon: Icons.calendar_today,
            label: 'Esta Semana',
            value: '35h 15m',
            color: AppColors.success,
          ),
          _StatCard(
            icon: Icons.trending_up,
            label: 'Média Diária',
            value: '8h 05m',
            color: AppColors.warning,
          ),
          _StatCard(
            icon: Icons.coffee,
            label: 'Pausas Hoje',
            value: '1h 15m',
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}