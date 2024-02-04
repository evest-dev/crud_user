import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_user/views/home_screen.dart';

class AddUsers extends StatefulWidget {
  static const String name = "add_screen";
  const AddUsers({super.key});

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final CollectionReference _users =
      FirebaseFirestore.instance.collection("users");

  _addUser() {
    _users.add({
      'name': _nameController.text,
      'last_name': _lastNameController.text,
      'email': _mailController.text,
      'phone': _phoneController.text
    });
    _nameController.clear();
    _lastNameController.clear();
    _mailController.clear();
    _phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
          title: Text('Add Users', style: TextStyle(color: colors.secondary, fontWeight: FontWeight.w600))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                  labelText: 'Name', suffixIcon: Icon(Icons.person)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                  labelText: 'Last Name', suffixIcon: Icon(Icons.person)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _mailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  suffixIcon: Icon(Icons.mail, color: colors.secondary)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                  labelText: 'Phone', suffixIcon: Icon(Icons.phone)),
            ),
            const SizedBox(height: 35),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: FilledButton(
                  onPressed: () {
                    _addUser();
                    context.goNamed(HomeScreen.name);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('User registred!')));
                  },
                  child: const Text('Save',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500))),
            ),
            
            //ListUsers

          ]),
        ),
      ),
    );
  }
}

