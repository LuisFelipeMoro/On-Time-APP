import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthService extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    
    // Simulate login delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock successful login
    _currentUser = UserModel(
      id: '1',
      email: email,
      name: 'Usuário Teste',
      role: email.contains('admin') ? UserRole.admin : UserRole.employee,
    );
    
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<void> signOut() async {
    _currentUser = null;
    notifyListeners();
  }
}