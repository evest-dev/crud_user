import 'package:crud_user/config/menu/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const String name = "home_screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'CRUD Flutter + Firebase',
        style: TextStyle(fontWeight: FontWeight.w500, color: colors.secondary),
      )),
      body: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const CustomButtonListTile();
  }
}

class CustomButtonListTile extends StatelessWidget {
  const CustomButtonListTile({super.key});

  
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListView.builder(
      itemCount: buttonMenuItem.length,
      itemBuilder: (context, index) {
        final menuItem = buttonMenuItem[index];
        return ListTile(
          leading: 
            Icon(menuItem.icon, color: colors.primary),
          trailing:
            Icon(Icons.arrow_forward_ios, color: colors.primary, size: 18),
          title:
            Text(menuItem.title, style: TextStyle(color: colors.secondary)),
          subtitle: 
            Text(menuItem.subtitle, style: TextStyle(color: colors.secondary)),
          onTap: () {
            // Navigator.pushNamed(context, menuItem.link);
            context.push(menuItem.link);
          },
        );
      },
    );
  }
}
