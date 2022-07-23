import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_humberto/Login/ui/screens/login_screen.dart';
import 'package:prueba_humberto/User/ui/screens/user_screen.dart';
import 'package:prueba_humberto/bloc/auth/auth_bloc.dart';
import 'package:prueba_humberto/utils/constants.dart';
import 'package:prueba_humberto/data/repositories/auth_repository.dart';
import 'package:prueba_humberto/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            primarySwatch: Palette.kPrimarySwatch,
            textTheme: const TextTheme(),
            scaffoldBackgroundColor: kPrimaryLigthColor,
          ),
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const UserScreen();
                }
                return const LoginScreen();
              }),
        ),
      ),
    );
  }
}
