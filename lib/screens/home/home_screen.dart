import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../models/user_model.dart';
import '../admin/admin_panel_screen.dart';
import '../reports/reports_screen.dart';
import 'timesheet_screen.dart';
import '../../widgets/app_header.dart';
import '../../utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final isAdmin = authService.currentUser?.role == UserRole.admin;
    final userName = authService.currentUser?.name ?? '';

    final baseScreens = [
      const TimesheetScreen(),
      const ReportsScreen(),
      const Center(child: Text('Histórico')), // Placeholder
      const Center(child: Text('Perfil')), // Placeholder
    ];
    
    final screens = isAdmin ? [...baseScreens, const AdminPanelScreen()] : baseScreens;

    return Scaffold(
      appBar: AppHeader(
        userName: userName,
        isAdmin: isAdmin,
        onLogout: () => authService.signOut(),
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.cardBackground,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Ponto',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Relatórios',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Histórico',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          if (isAdmin)
            const BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings),
              label: 'Admin',
            ),
        ],
      ),
    );
  }
}