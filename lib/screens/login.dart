import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test3/screens/home.dart';
import 'package:test3/screens/signup.dart';

import '../widgets/customButton.dart';
import '../widgets/textFormField.dart';

class Login extends StatefulWidget {
  static const String routeName = "Login";

  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 235, 236),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: const Color.fromARGB(255, 176, 179, 182),
              ),
              height: MediaQuery.of(context).size.height * .2,
              child: Image.asset("assets/quran_tab_logo.png"),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "login to continue using the app",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  CustomTextForm(textHint: "Email", myController: email),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomTextForm(
                        textHint: "Password",
                        myController: password,
                      ),
                      Text(
                        "forget password?",
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ],
                  ),
                  CustomButton(
                    title: "Login",
                    onPressed: () async {
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                              email: email.text,
                              password: password.text,
                            );
                        Navigator.pushReplacementNamed(context, Home.routeName);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'invalid-email') {
                          print("No user found for that email");
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                            title: 'Email',
                            desc: 'No user found for that email.',
                          ).show();
                          print('No user found for that email.');
                        } else if (e.code == 'invalid-credential') {
                          print('Wrong password provided for that user.');
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: 'Wrong Passord',
                            desc: 'Wrong password provided for that user',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          ).show();
                        }
                      }
                    },
                  ),
                  Row(
                    children: [
                      Expanded(child: Divider(thickness: 1)),
                      Text(
                        "Or Login with",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      Expanded(child: Divider(thickness: 1)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .3,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image: AssetImage("assets/facebook.png"),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .3,
                        padding: EdgeInsets.all(3),
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset("assets/search.png"),
                      ),
                      Container(
                        padding: EdgeInsets.all(3),
                        width: MediaQuery.of(context).size.width * .3,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset("assets/apple-logo.png"),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("don't have an account?"),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              Register.routeName,
                            );
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
