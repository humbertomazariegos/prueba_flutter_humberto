import 'package:prueba_humberto/Login/ui/screens/login_screen.dart';
import 'package:prueba_humberto/User/ui/widgets/label_button.dart';
import 'package:prueba_humberto/bloc/auth/auth_bloc.dart';
import 'package:prueba_humberto/bloc/auth/auth_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_humberto/utils/constants.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Stack(
      children: [
        Container(
          height: 220.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [kPrimaryDarkColor, kPrimaryColor],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp),
          ),
          alignment: const Alignment(-0.9, -0.6),
        ),
        ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Text(
                user.displayName![0],
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryDarkColor,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "${user.displayName}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Center(
              child: Text(
                "${user.email}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        ListView(
          padding: const EdgeInsets.only(top: 250, left: 15, right: 15),
          children: [
            const Text(
              "Información de la cuenta",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            LabelButton(
              label: "Name",
              value: "${user.displayName}",
            ),
            LabelButton(
              label: "Email",
              value: "${user.email}",
            ),
            const LabelButton(
              label: "Telefono",
              value: "23212231",
            ),
            ElevatedButton(
              child: const Text(
                'Sign Out',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onPressed: () {
                context.read<AuthBloc>().add(SignOutRequested());
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new LoginScreen()));
              },
            ),
          ],
        ),
      ],
    );
  }
}
