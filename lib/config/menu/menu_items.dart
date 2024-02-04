import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subtitle;
  final String link;
  final IconData icon;

  const MenuItem(
      {required this.title,
      required this.subtitle,
      required this.icon,
      required this.link});
}

const buttonMenuItem = <MenuItem>[
  MenuItem(
    title: 'Add Users', 
    subtitle: 'Add to new user', 
    link: '/add',
    icon: Icons.person_add
  ),
  MenuItem(
    title: 'List Users', 
    subtitle: 'List to all users', 
    link: '/list',
    icon: Icons.person_pin_rounded
  )
];
