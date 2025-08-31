import 'package:flutter/material.dart';
import '../../models/timesheet_model.dart';
import '../../widgets/time_clock_card.dart';
import '../../widgets/quick_stats_grid.dart';
import '../../widgets/recent_activity_feed.dart';
import '../../utils/app_colors.dart';

class TimesheetScreen extends StatefulWidget {
  const TimesheetScreen({super.key});

  @override
  State<TimesheetScreen> createState() => _TimesheetScreenState();
}

class _TimesheetScreenState extends State<TimesheetScreen> {
  EntryType? _lastEntryType;
  final List<TimesheetEntry> _todayEntries = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TimeClockCard(
              lastEntryType: _lastEntryType,
              onClockAction: _recordEntry,
            ),
            const SizedBox(height: 24),
            const QuickStatsGrid(),
            const SizedBox(height: 24),
            RecentActivityFeed(entries: _todayEntries),
            const SizedBox(height: 80), // Bottom navigation padding
          ],
        ),
      ),
    );
  }

  void _recordEntry(EntryType type) {
    final entry = TimesheetEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'current_user_id',
      timestamp: DateTime.now(),
      type: type,
    );

    setState(() {
      _todayEntries.add(entry);
      _lastEntryType = type;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_getEntryLabel(type)} registrado!'),
        backgroundColor: AppColors.success,
      ),
    );
  }



  String _getEntryLabel(EntryType type) {
    switch (type) {
      case EntryType.clockIn:
        return 'Entrada';
      case EntryType.breakStart:
        return 'Início Pausa';
      case EntryType.breakEnd:
        return 'Fim Pausa';
      case EntryType.clockOut:
        return 'Saída';
    }
  }
}