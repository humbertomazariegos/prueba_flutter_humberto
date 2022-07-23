import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prueba_humberto/User/model/user_model.dart';
import 'package:prueba_humberto/User/repository/users_repository.dart';
import 'package:prueba_humberto/User/ui/widgets/send_mail_button.dart';

import '../../../../utils/constants.dart';

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
    super.initState();
    loadUsers();
  }

  loadUsers() async {
    List<UserModel> auxUser = await UsersRepository().fetchUsers();
    if (this.mounted) {
      // check whether the state object is in tree
      setState(() {
        users = auxUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, i) => Card(
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
            trailing: SendMailButton(
              email: users[i].email,
              displayName: users[i].displayName,
            ),
          ),
        ),
      ),
    );
  }
}
