import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/customButton.dart';
import '../widgets/textFormField.dart';
import 'home.dart';

class Register extends StatelessWidget {
  static const String routeName = "Register";
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmingPassword = TextEditingController();
  Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: const Color.fromARGB(255, 231, 235, 236),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .2,
            child: Image.asset("assets/quran_tab_logo.png"),
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
                        "Register",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Enter your pesonal information",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  CustomTextForm(textHint: "User Name", myController: userName),
                  CustomTextForm(textHint: "Email", myController: email),
                  CustomTextForm(textHint: "Password", myController: password),
                  CustomTextForm(
                    textHint: "Confirm Password",
                    myController: confirmingPassword,
                  ),
                  CustomButton(
                    title: "Register",
                    onPressed: () async {
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                              email: email.text,
                              password: password.text,
                            );
                        Navigator.pushReplacementNamed(context, Home.routeName);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .06),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
