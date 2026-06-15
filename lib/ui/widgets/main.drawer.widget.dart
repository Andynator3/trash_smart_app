import 'package:flutter/material.dart';

import 'drawer.item.widget.dart';
import 'main.drawer.header.widget.dart';
import '../../../models/drawer_item.model.dart';


class MainDrawer extends StatelessWidget {
  // 2. La liste est sortie du build et définie en constante
  final List<DrawerItem> menus = const [
    DrawerItem(title: "Accueil", route: "/", leadingIcon: Icons.home, trailingIcon: Icons.arrow_forward),
    DrawerItem(title: "Utilisateurs", route: "/users", leadingIcon: Icons.person, trailingIcon: Icons.arrow_forward),
    DrawerItem(title: "Poubelles", route: "/trashcan", leadingIcon: Icons.restore_from_trash_outlined, trailingIcon: Icons.arrow_forward),
    DrawerItem(title: "Déchets", route: "/trash", leadingIcon: Icons.restore_from_trash, trailingIcon: Icons.arrow_forward)
  ];

  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const MainDrawerHeader(),
          Expanded(
            child: ListView.separated(
              itemCount: menus.length,
              itemBuilder: (context, index) {
                // 3. Récupération de l'objet typé
                final menu = menus[index];

                return DrawerItemWidget(
                  title: menu.title,
                  leadingIcon: menu.leadingIcon,
                  trailingIcon: menu.trailingIcon,
                  onAction: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, menu.route);
                  },
                );
              },
              // 4. Syntaxe allégée pour le séparateur
              separatorBuilder: (context, index) => const Divider(height: 5),
            ),
          )
        ],
      ),
    );
  }
}
