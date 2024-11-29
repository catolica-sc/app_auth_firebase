import 'package:flutter/material.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthViewModel authViewModel = Provider.of(context);
    final user = authViewModel.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: Text('Nenhum usuário logado'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            key: Key('logoutButton'),
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authViewModel.signOut(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Imagem de fundo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Fundo_catolica.jpg'), // Certifique-se de ter a imagem no diretório assets
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Conteúdo da tela
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Name: ${user.displayName ?? 'Guest'}'),
                Text('Email: ${user.email ?? 'No email'}'),
                user.photoURL != null ? Image.network(user.photoURL!) : Container(),
                SizedBox(height: 32),
                // Botão decorado de desconectar login
                ElevatedButton(
                  key: Key('logoutButton'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red, // Cor do texto do botão
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  onPressed: () async {
                    await authViewModel.signOut(context);
                  },
                  child: Text('Desconectar Login'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}