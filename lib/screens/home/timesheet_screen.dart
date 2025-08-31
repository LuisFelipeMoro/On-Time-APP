import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/timesheet_model.dart';
import '../../widgets/action_button.dart';
import '../../widgets/section_card.dart';

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    DateFormat('EEEE, dd/MM/yyyy').format(DateTime.now()),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    DateFormat('HH:mm:ss').format(DateTime.now()),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildActionButtons(),
          const SizedBox(height: 24),
          Expanded(
            child: _buildTodayEntries(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        if (_lastEntryType == null || _lastEntryType == EntryType.clockOut)
          ActionButton(
            label: 'Entrada',
            onPressed: () => _recordEntry(EntryType.clockIn),
            backgroundColor: Colors.green,
            icon: Icons.login,
          ),
        
        if (_lastEntryType == EntryType.clockIn || _lastEntryType == EntryType.breakEnd)
          ActionButton(
            label: 'Início Pausa',
            onPressed: () => _recordEntry(EntryType.breakStart),
            backgroundColor: Colors.orange,
            icon: Icons.pause,
          ),
        
        if (_lastEntryType == EntryType.breakStart)
          ActionButton(
            label: 'Fim Pausa',
            onPressed: () => _recordEntry(EntryType.breakEnd),
            backgroundColor: Colors.blue,
            icon: Icons.play_arrow,
          ),
        
        if (_lastEntryType == EntryType.clockIn || _lastEntryType == EntryType.breakEnd)
          ActionButton(
            label: 'Saída',
            onPressed: () => _recordEntry(EntryType.clockOut),
            backgroundColor: Colors.red,
            icon: Icons.logout,
          ),
      ],
    );
  }



  Widget _buildTodayEntries() {
    return SectionCard(
      title: 'Registros de Hoje',
      child: Expanded(
        child: ListView.builder(
          itemCount: _todayEntries.length,
          itemBuilder: (context, index) {
            final entry = _todayEntries[index];
            return ListTile(
              leading: Icon(_getEntryIcon(entry.type)),
              title: Text(_getEntryLabel(entry.type)),
              trailing: Text(DateFormat('HH:mm').format(entry.timestamp)),
            );
          },
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
      SnackBar(content: Text('${_getEntryLabel(type)} registrado!')),
    );
  }

  IconData _getEntryIcon(EntryType type) {
    switch (type) {
      case EntryType.clockIn:
        return Icons.login;
      case EntryType.breakStart:
        return Icons.pause;
      case EntryType.breakEnd:
        return Icons.play_arrow;
      case EntryType.clockOut:
        return Icons.logout;
    }
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