import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prueba_humberto/bloc/user/user_model.dart';
import 'package:prueba_humberto/data/repositories/users_repository.dart';

import '../../../../constants.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: UserList(),
      ),
    );
  }
}

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<UserModel> users = [];

  @override
  void initState() {
    loadUsers();
    super.initState();
  }

  loadUsers() async {
    List<UserModel> auxUser = await UsersRepository().fetchUsers();
    setState(() {
      users = auxUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, i) => Dismissible(
        key: Key(i.toString()),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {},
        background: Container(
          color: Colors.red,
          padding: const EdgeInsets.only(left: 5),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: kPrimaryLigthColor,
                    child: Text(
                      users[i].displayName[0] + users[i].displayName[1],
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                          color: kPrimaryDarkColor),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(users[i].displayName),
                ],
              ),
              trailing: MaterialButton(
                onPressed: () {
                  //Navigator.pushNamed(context, "/create", arguments: users[i]);
                  UsersRepository().fetchUsers();
                },
                child: const Icon(Icons.mail_outline),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
