import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/app_colors.dart';
import '../models/timesheet_model.dart';

class TimeClockCard extends StatefulWidget {
  final EntryType? lastEntryType;
  final Function(EntryType) onClockAction;

  const TimeClockCard({
    super.key,
    this.lastEntryType,
    required this.onClockAction,
  });

  @override
  State<TimeClockCard> createState() => _TimeClockCardState();
}

class _TimeClockCardState extends State<TimeClockCard> {
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _currentTime = DateTime.now());
        _startTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              DateFormat('HH:mm:ss').format(_currentTime),
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat('EEEE, dd MMMM yyyy').format(_currentTime),
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            _buildStatusBadge(),
            const SizedBox(height: 24),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    final status = _getStatusInfo();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: status['color'],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status['text'],
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        _buildPrimaryButton(),
        const SizedBox(height: 12),
        if (_shouldShowSecondaryButton()) _buildSecondaryButton(),
      ],
    );
  }

  Widget _buildPrimaryButton() {
    final action = _getPrimaryAction();
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => widget.onClockAction(action['type']),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(
          action['text'],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: () => widget.onClockAction(EntryType.clockOut),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Text(
          'Registrar Saída',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _getStatusInfo() {
    switch (widget.lastEntryType) {
      case EntryType.clockIn:
      case EntryType.breakEnd:
        return {'text': 'Trabalhando', 'color': AppColors.success};
      case EntryType.breakStart:
        return {'text': 'Em pausa', 'color': AppColors.warning};
      default:
        return {'text': 'Fora do expediente', 'color': AppColors.textSecondary};
    }
  }

  Map<String, dynamic> _getPrimaryAction() {
    switch (widget.lastEntryType) {
      case EntryType.clockIn:
      case EntryType.breakEnd:
        return {'text': 'Iniciar Pausa', 'type': EntryType.breakStart};
      case EntryType.breakStart:
        return {'text': 'Finalizar Pausa', 'type': EntryType.breakEnd};
      default:
        return {'text': 'Registrar Entrada', 'type': EntryType.clockIn};
    }
  }

  bool _shouldShowSecondaryButton() {
    return widget.lastEntryType == EntryType.clockIn || 
           widget.lastEntryType == EntryType.breakEnd;
  }
}