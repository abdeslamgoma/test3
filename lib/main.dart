import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test3/screens/home.dart';
import 'package:test3/screens/login.dart';
import 'package:test3/screens/signup.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Test3());
}

class Test3 extends StatefulWidget {
  const Test3({super.key});

  @override
  State<Test3> createState() => _Test2State();
}

class _Test2State extends State<Test3> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Login.routeName: (_) => Login(),
        Register.routeName: (_) => Register(),
        Home.routeName: (_) => Home(),
      },
      home: FirebaseAuth.instance.currentUser == null ? Login() : Home(),
    );
  }
}
