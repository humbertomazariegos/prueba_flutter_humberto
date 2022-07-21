import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prueba_humberto/bloc/user/user_model.dart';
import 'package:prueba_humberto/data/repositories/mail_repository.dart';
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
            trailing: SendMailButton(),
          ),
        ),
      ),
    );
  }
}

class SendMailButton extends StatefulWidget {
  const SendMailButton({
    Key? key,
  }) : super(key: key);

  @override
  State<SendMailButton> createState() => _SendMailButtonState();
}

class _SendMailButtonState extends State<SendMailButton> {
  var send = false;

  sendChage() {
    setState(() {
      send = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        var resp = "";
        send == true
            ? resp = "OK"
            // var resp = MailRepository().sendMail(
            //     "test.test@gmail.com",
            //     "Humberto",
            //     users[i].email,
            //     users[i].displayName,
            //     "Invitacion",
            //     "Esta es una invitacion",
            //     "<h1>hola</h1>");
            : resp = "ERROR";

        if (resp == "OK") {
          sendChage();
          showAlertDialog(context, "OK");
        } else {
          showAlertDialog(context, "ERROR");
        }
      },
      child: send == true ? Icon(Icons.check) : Icon(Icons.mail_outline),
    );
  }
}

showAlertDialog(BuildContext context, String type) {
  // Create button
  var title = "";
  var text = "";

  type == "OK" ? title = "EXITOSO" : title = "ERROR";
  type == "OK"
      ? text = "El correo fue enviado exitosamente."
      : text = "No se envio el correo";

  Widget okButton = ElevatedButton(
    child: Text("OK", style: TextStyle(color: Colors.white)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      title,
      style: TextStyle(
        color: type == "OK" ? Colors.black : Colors.red,
      ),
    ),
    content: Text(text),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
