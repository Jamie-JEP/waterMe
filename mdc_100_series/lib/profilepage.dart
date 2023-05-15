import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'signin_widget.dart';
import 'model/product.dart';
import 'model/products_repository.dart';
import 'alarm.dart';
import 'enroll.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),

        child:Column(
          children:[
            Center(
              child:Column(
                children: <Widget>[
                  const SizedBox(height: 16.0,),
                  Container(
                    child:Column(
                      children: const [
                        //user 이름(로그인?)
                        Text("An Hyebin"),
                      ],
                    )
                  ),
                  SizedBox(height: 400,),
                  ElevatedButton(
                    child: const Text('Log-out'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginWidget()),
                      );
                    },
                  ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
