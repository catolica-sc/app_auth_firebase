import 'package:flutter/material.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthViewModel authViewModel = Provider.of<AuthViewModel>(context);
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${user.displayName ?? 'Guest'}'),
            Text('Email: ${user.email ?? 'No email'}'),
            user.photoURL != null ? Image.network(user.photoURL!) : Container(),
          ],
        ),
      ),
    );
  }
}