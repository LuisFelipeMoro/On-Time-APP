import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets/info_card.dart';
import '../../widgets/section_card.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedPeriod = 'Semana Atual';
  final List<String> _periods = ['Semana Atual', 'Mês Atual', 'Período Personalizado'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPeriodSelector(),
          const SizedBox(height: 24),
          _buildReportCards(),
          const SizedBox(height: 24),
          Expanded(child: _buildDetailedReport()),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Período', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedPeriod,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _periods.map((period) {
                return DropdownMenuItem(value: period, child: Text(period));
              }).toList(),
              onChanged: (value) => setState(() => _selectedPeriod = value!),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCards() {
    return const Row(
      children: [
        Expanded(
          child: InfoCard(
            icon: Icons.access_time,
            label: 'Horas Trabalhadas',
            value: '40h 30m',
            iconColor: Colors.blue,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: InfoCard(
            icon: Icons.warning,
            label: 'Inconsistências',
            value: '2',
            iconColor: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedReport() {
    return SectionCard(
      title: 'Detalhamento Diário',
      child: Expanded(
        child: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) {
            final date = DateTime.now().subtract(Duration(days: index));
            return ListTile(
              leading: CircleAvatar(
                child: Text(DateFormat('dd').format(date)),
              ),
              title: Text(DateFormat('EEEE').format(date)),
              subtitle: Text(DateFormat('dd/MM/yyyy').format(date)),
              trailing: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('8h 15m', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Completo', style: TextStyle(color: Colors.green, fontSize: 12)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}