import 'package:flutter/material.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthViewModel authViewModel = Provider.of(context);
    final user = authViewModel.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: const Center(
          child: Text('Nenhum usuário logado'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            key: const Key('logoutButton'),
            icon: const Icon(Icons.logout),
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Fundo_catolica.jpg'), // Certifique-se de ter a imagem no diretório assets
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Conteúdo da tela
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 80), // Ajuste a altura conforme necessário
                const Text(
                  'Boas férias até 2025',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Pacifico',
                  ),
                ),
                const SizedBox(height: 60),
                Text(
                  ' ${user.displayName ?? 'Guest'}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Pacifico',
                  ),
                ),
                const SizedBox(height: 20),
                user.photoURL != null
                    ? Image.network(
                  user.photoURL!,
                  height: 350,
                  width: 350,
                )
                    : Container(),
                const SizedBox(height: 40),

                ElevatedButton(
                  key: const Key('logoutButton'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red, // Cor do texto do botão
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                  onPressed: () async {
                    await authViewModel.signOut(context);
                  },
                  child: const Text('Desconectar Login'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}