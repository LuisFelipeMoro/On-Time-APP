import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets/info_card.dart';
import '../../widgets/section_card.dart';
import '../../widgets/action_button.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final List<Map<String, dynamic>> _employees = [
    {'name': 'João Silva', 'status': 'Trabalhando', 'lastEntry': DateTime.now().subtract(const Duration(hours: 2))},
    {'name': 'Maria Santos', 'status': 'Pausa', 'lastEntry': DateTime.now().subtract(const Duration(minutes: 15))},
    {'name': 'Pedro Costa', 'status': 'Ausente', 'lastEntry': DateTime.now().subtract(const Duration(hours: 8))},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCards(),
          const SizedBox(height: 24),
          _buildEmployeeList(),
          const SizedBox(height: 24),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return const Row(
      children: [
        Expanded(
          child: InfoCard(
            icon: Icons.people,
            label: 'Presentes',
            value: '2',
            iconColor: Colors.green,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: InfoCard(
            icon: Icons.person_off,
            label: 'Ausentes',
            value: '1',
            iconColor: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildEmployeeList() {
    return Expanded(
      child: SectionCard(
        title: 'Status da Equipe',
        child: Expanded(
          child: ListView.builder(
            itemCount: _employees.length,
            itemBuilder: (context, index) {
              final employee = _employees[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getStatusColor(employee['status']),
                  child: Text(employee['name'][0]),
                ),
                title: Text(employee['name']),
                subtitle: Text('Último registro: ${DateFormat('HH:mm').format(employee['lastEntry'])}'),
                trailing: Chip(
                  label: Text(employee['status']),
                  backgroundColor: _getStatusColor(employee['status']).withValues(alpha: 0.2),
                ),
                onTap: () => _showEmployeeDetails(employee),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: ActionButton(
            label: 'Adicionar Registro',
            onPressed: _showAddEntryDialog,
            backgroundColor: Colors.blue,
            icon: Icons.add,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ActionButton(
            label: 'Gerar Relatório',
            onPressed: _generateReport,
            backgroundColor: Colors.green,
            icon: Icons.file_download,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Trabalhando':
        return Colors.green;
      case 'Pausa':
        return Colors.orange;
      case 'Ausente':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showEmployeeDetails(Map<String, dynamic> employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(employee['name']),
        content: Text('Detalhes do funcionário ${employee['name']}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _showAddEntryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar Registro'),
        content: const Text('Funcionalidade para adicionar registro manual'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  void _generateReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Relatório gerado com sucesso!')),
    );
  }
}