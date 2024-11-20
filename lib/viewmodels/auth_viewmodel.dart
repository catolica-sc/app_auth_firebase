import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? get currentUser => _authService.getCurrentUser();

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final User? user = await _authService.signInWithGoogle();
      if (user == null) {
        return null; // O usuário cancelou o login ou houve um erro
      }

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'displayName': user.displayName,
        'email': user.email,
        'photoURL': user.photoURL,
      });

      return user;
    } catch (e) {
      print('Erro ao fazer login com Google: $e');
      return null;
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _authService.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }
}