// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shrine/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shrine/main.dart';
import 'package:shrine/signup_widget.dart';
import 'package:shrine/utils.dart';


class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
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
            Column(
              children: <Widget>[
                Image.asset(
                    'assets/waterme_logo.png', width: 300, fit: BoxFit.fill),
              ],
            ),
            const SizedBox(height: 120.0),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            OverflowBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  child: const Text('Sign Up'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpWidget()),
                    );
                  },
                ),
                const SizedBox(width: 50.0),
                ElevatedButton(
                  child: const Text('Sign In'),
                  onPressed: () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(email: emailController.text, password: passwordController.text)
                        .then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()));
                    }).onError((error, stackTrace){
                      print("Error ${error.toString()}");
                    });
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
