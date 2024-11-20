import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? get currentUser => _authService.getCurrentUser();

  Future<User?> signInWithGoogle(BuildContext context) async {
    User? user = await _authService.signInWithGoogle();
    return user;
  }

  Future<void> signOut(BuildContext context) async {
    await _authService.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }
}