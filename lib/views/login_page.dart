import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthViewModel authViewModel = Provider.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Fundo_catolica.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Avaliação N3 - Desenvolvimento de App com Autenticação em Provedor do Firebase',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Alunos:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                        Text(
                          'Santhiago Chapiewski\nPedro Henrique Santos\nVinicius Froes',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  // Botão de login com Google
                  ElevatedButton.icon(
                    key: Key('googleLoginButton'),
                    icon: Image.asset('assets/Icone_google.jpg', height: 32),
                    label: Text('Login com Google'),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
