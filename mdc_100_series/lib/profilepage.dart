import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signin_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 200.0),
                  Container(
                    child: Column(
                      children: [
                        // Display logged-in user email
                        Text(_user?.email ?? 'Unknown User',
                          style: TextStyle(fontSize: 28),),
                      ],
                    ),
                  ),
                  SizedBox(height: 200),
                  ElevatedButton(
                    child: const Text('Log-out'),
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginWidget()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
