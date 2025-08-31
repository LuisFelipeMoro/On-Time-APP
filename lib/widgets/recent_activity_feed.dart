import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/app_colors.dart';
import '../models/timesheet_model.dart';

class RecentActivityFeed extends StatelessWidget {
  final List<TimesheetEntry> entries;

  const RecentActivityFeed({
    super.key,
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Atividade Recente',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          if (entries.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Nenhuma atividade hoje',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: entries.length > 5 ? 5 : entries.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final entry = entries[entries.length - 1 - index];
                return _ActivityItem(entry: entry);
              },
            ),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final TimesheetEntry entry;

  const _ActivityItem({required this.entry});

  @override
  Widget build(BuildContext context) {
    final info = _getEntryInfo();
    
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: (info['color'] as Color).withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          info['icon'],
          color: info['color'],
          size: 20,
        ),
      ),
      title: Text(
        info['title'],
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        DateFormat('dd/MM/yyyy').format(entry.timestamp),
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: info['color'],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          DateFormat('HH:mm').format(entry.timestamp),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _getEntryInfo() {
    switch (entry.type) {
      case EntryType.clockIn:
        return {
          'title': 'Entrada registrada',
          'icon': Icons.login,
          'color': AppColors.success,
        };
      case EntryType.clockOut:
        return {
          'title': 'Saída registrada',
          'icon': Icons.logout,
          'color': AppColors.textSecondary,
        };
      case EntryType.breakStart:
        return {
          'title': 'Pausa iniciada',
          'icon': Icons.pause,
          'color': AppColors.warning,
        };
      case EntryType.breakEnd:
        return {
          'title': 'Pausa finalizada',
          'icon': Icons.play_arrow,
          'color': AppColors.primary,
        };
    }
  }
}