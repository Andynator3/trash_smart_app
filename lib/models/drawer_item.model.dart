import 'package:flutter/material.dart';

// 1. Création d'un modèle pour un typage strict (façon Java/Angular)
class DrawerItem {
  final String title;
  final String route;
  final IconData leadingIcon;
  final IconData trailingIcon;

  const DrawerItem({
    required this.title,
    required this.route,
    required this.leadingIcon,
    required this.trailingIcon,
  });
}