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

import 'package:flutter/material.dart';
import 'package:shrine/home.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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
                Image.asset('assets/waterme_logo.png', width: 300, fit: BoxFit.fill ),
              ],
            ),
            const SizedBox(height: 120.0),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
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
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  }, 
                ),
                const SizedBox(width:50.0),
                ElevatedButton(
                  child: const Text('NEXT'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
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

// class SignUp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Sign up page"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text('Go back!'),
//         ),
//       ),
//     );
//   }
// }

class SignUp extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ConfirmpasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Widget build (BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Form(
          key: _formkey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            children: <Widget>[
              const SizedBox(height: 50.0),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value ==null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  if(!validateStructure(_usernameController.text)) {
                    return 'Username is invalid';

                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value ==null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _ConfirmpasswordController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value ==null || value.isEmpty) {
                    return 'Please enter confirmPassword';
                  }
                  if (_ConfirmpasswordController.text!=_passwordController.text) {
                    return "Confirm Password doesnʼt match Password";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Email Address',
                ),
                validator: (value) {
                  if (value ==null || value.isEmpty) {
                    return 'Please enter Email Address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              OverflowBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text('SIGN UP'),
                    onPressed: () {
                      if (_formkey.currentState!.validate()){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),   
    );
  }
}


bool validateStructure(String value){
  String  pattern = r'^(?=.*?[a-zA-Z]{3,50})(?=.*?\d{3,50}).{6,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}


