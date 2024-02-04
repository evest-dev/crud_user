import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListUsers extends StatefulWidget {
  static const String name = "list_screen";
  const ListUsers({super.key});

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final CollectionReference _users =
      FirebaseFirestore.instance.collection("users");


  //EditUser
  _editUser(DocumentSnapshot user) {
    _nameController.text = user['name'];
    _lastNameController.text = user['last_name'];
    _mailController.text = user['email'];
    _phoneController.text = user['phone'].toString();

    final colors = Theme.of(context).colorScheme;

    showDialog(
        context: context,
        builder: (context) {
          return ListView(
            children: [
              AlertDialog(
                title: Text('Edit Users', style: TextStyle(color: colors.primary)),
                content: Column(mainAxisSize: MainAxisSize.min, children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        labelText: 'Name', suffixIcon: Icon(Icons.person)),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                        labelText: 'Last Name', suffixIcon: Icon(Icons.person)),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _mailController,
                    decoration: const InputDecoration(
                        labelText: 'Email', suffixIcon: Icon(Icons.mail)),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                        labelText: 'Phone', suffixIcon: Icon(Icons.phone)),
                  ),
                ]),
                actions: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          _updateUser(user.id);
                          Navigator.pop(context);
                          
                        },
                        child: const Text('Update')),
                  ),
                ],
                
              ),
            ]
          );
        });
        FocusManager.instance.primaryFocus?.unfocus();

  }

  //_updateUser
  void _updateUser(String userId) {
    _users.doc(userId).update({
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

  //DeleteUsers
  void deleteUser(String userId) {
    _users.doc(userId).delete();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
        appBar: AppBar(
          title: Text('List of Users',
              style: TextStyle(
                  color: colors.secondary, fontWeight: FontWeight.w600)),
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: StreamBuilder(
              stream: _users.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var user = snapshot.data!.docs[index];
                      return Dismissible(
                        key: Key(user.id),
                        background: Container(
                          color: Colors.redAccent,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 16),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (direction) {
                          deleteUser(user.id);
                        },
                        direction: DismissDirection.endToStart,
                        child: ListTile(
                          title: Text(
                            "${user['name']} ${user['last_name']}",
                            style: TextStyle(color: colors.primary),
                          ),
                          subtitle: Text("${user['email']}\n${user['phone']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: colors.secondary,
                                  fontSize: 15)),
                          trailing: IconButton(
                              onPressed: () {
                                _editUser(user);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: colors.primary,
                              )),
                        ),
                      );
                    });
              },
            )));
  }
}
