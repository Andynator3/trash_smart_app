import 'package:flutter/material.dart';

class DrawerItemWidget extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final VoidCallback onAction; // 1. Typage strict

  const DrawerItemWidget({
    Key? key,
    required this.title,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.onAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // 2. Mise à jour vers Material 3
      title: Text(title, style: Theme.of(context).textTheme.titleLarge),
      leading: Icon(leadingIcon, color: Theme.of(context).primaryColor),
      trailing: Icon(trailingIcon, color: Theme.of(context).primaryColor),
      // 3. Appel direct sans fonction fléchée
      onTap: onAction,
    );
  }
}
