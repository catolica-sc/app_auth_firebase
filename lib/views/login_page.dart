import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthViewModel authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          key: Key('googleLoginButton'),
          onPressed: () async {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(child: CircularProgressIndicator()),
            );

            try {
              User? user = await authViewModel.signInWithGoogle(context);
              Navigator.pop(context); // Fechar o indicador de carregamento
              if (user != null) {
                Navigator.pushReplacementNamed(context, '/home');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Falha de login pela conta Google')),
                );
              }
            } catch (e) {
              Navigator.pop(context); // Fechar o indicador de carregamento
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erro: $e')),
              );
            }
          },
          child: Text('Login com Google'),
        ),
      ),
    );
  }
}