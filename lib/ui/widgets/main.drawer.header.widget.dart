import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/bloc_themes/theme.bloc.dart';
import '../../blocs/bloc_themes/theme.event.dart';

class MainDrawerHeader extends StatelessWidget {
  const MainDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Theme.of(context).primaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center, // Aligne verticalement au centre
        children: [
          // Bloc Gauche : Avatar + Infos textuelles
          Row(
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage("images/user-1.png"),
              ),
              const SizedBox(width: 12), // Espace entre l'avatar et le texte

              // CODE À AJOUTER : Affichage du pseudo et de l'email
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "user1",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "user1@gmail.com",
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),

          // Bloc Droite : Bouton Paramètres / Thème
          IconButton(
              onPressed: () {
                context.read<ThemeBloc>().add(SwitchThemeEvent());
              },
              icon: const Icon(Icons.settings, color: Colors.black87)
          )
        ],
      ),
    );
  }
}
