import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Ajuste les imports selon l'arborescence exacte
import '../../blocs/bloc_auth/auth.bloc.dart';
import '../../blocs/bloc_auth/auth.event.dart';
import '../../blocs/bloc_auth/auth.state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Les contrôleurs pour lire les champs de texte
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Nettoyage de la mémoire (pratique standard)
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            // 1. Le Listener s'occupe de la navigation et des alertes
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                // Remplacement de la route pour empêcher le retour en arrière
                Navigator.pushReplacementNamed(context, '/');
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.redAccent
                  ),
                );
              }
            },
            // 2. Le Builder s'occupe du rendu visuel
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                      Icons.security,
                      size: 100,
                      color: Theme.of(context).primaryColor
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Nom d\'utilisateur',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Mot de passe',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Changement dynamique du bouton selon l'état
                  if (state is AuthLoading)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50), // Largeur totale
                      ),
                      onPressed: () {
                        // Envoi de l'événement au BLoC
                        context.read<AuthBloc>().add(
                          LoginRequested(
                            username: _usernameController.text,
                            password: _passwordController.text,
                          ),
                        );
                      },
                      child: const Text('Se connecter', style: TextStyle(fontSize: 18)),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
