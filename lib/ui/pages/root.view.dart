import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Importations des pages
import 'package:trash_smart_app/ui/pages/trash.page.dart';
import 'package:trash_smart_app/ui/pages/trashcan.page.dart';
import 'package:trash_smart_app/ui/pages/users.page.dart';
import 'package:trash_smart_app/ui/pages/home.page.dart';
import 'package:trash_smart_app/ui/pages/login.page.dart'; // Nouvel import

// Importations de tes BLoCs
import '../../blocs/bloc_themes/theme.bloc.dart';
import '../../blocs/bloc_themes/theme.state.dart';

class RootView extends StatelessWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.themeData,
            debugShowCheckedModeBanner: false, // Masque le bandeau de debug
            routes: {
              "/": (context) => const HomePage(),
              "/login": (context) => const LoginPage(), // Déclaration de la route de connexion
              "/users": (context) => const UsersPage(),
              "/trashcan": (context) => const TrashcanPage(),
              "/trash": (context) => const TrashPage(),
            },
            initialRoute: "/login", // Force le démarrage sur la page de connexion
          );
        }
    );
  }
}
