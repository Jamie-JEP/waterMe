import 'package:shrine/check.dart';
import 'package:shrine/login.dart';
import 'package:shrine/utils.dart';

import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';


class SignUpWidget extends StatefulWidget {

  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 120.0),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Image.asset(
                      'assets/waterme_logo.png', width: 300, fit: BoxFit.fill),
                ],
              ),
            ),
            const SizedBox(height: 120.0),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'New Email',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'Enter a valid email'
                      : null,
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'New Password',
              ),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value != null && value.length<6
                ? 'Enter min. 6 characters'
                  : null,
            ),
            const SizedBox(height: 20.0),
            OverflowBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: const Text('Sign Up'),
                  onPressed: () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text)
                        .then((value) {
                          print('Created New Account');
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginWidget()));
                    }).onError((error, stackTrace) {
                      print('Error ${error.toString()}');
                    });
                  },
                ),
                const SizedBox(width: 50.0),
                TextButton(
                  child: const Text('Sign In'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginWidget()),
                    );
                  },
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

