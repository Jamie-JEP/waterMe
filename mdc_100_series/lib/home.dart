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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'signin_widget.dart';
import 'model/product.dart';
import 'model/products_repository.dart';
import 'alarm.dart';
import 'enroll.dart';
import 'profilepage.dart';
import 'calendarpage.dart';
import 'homepage.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   List<Card> _buildGridCards(BuildContext context) {
//     List<Product> products = ProductsRepository.loadProducts(Category.all);

//     if (products.isEmpty) {
//       return const <Card>[];
//     }

//     final ThemeData theme = Theme.of(context);
//     final NumberFormat formatter = NumberFormat.simpleCurrency(
//         locale: Localizations.localeOf(context).toString());

//     return products.map((product) {
//       return Card(
//         clipBehavior: Clip.antiAlias,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             AspectRatio(
//               aspectRatio: 18 / 11,
//               child: Image.asset(
//                 product.assetName,
//                 package: product.assetPackage,
//                 fit: BoxFit.fitWidth,
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       product.name,
//                       style: theme.textTheme.headline6,
//                       maxLines: 1,
//                     ),
//                     const SizedBox(height: 8.0),
//                     Text(
//                       formatter.format(product.price),
//                       style: theme.textTheme.subtitle2,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     }).toList();
//   }

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authentication = FirebaseAuth.instance;

  User? loggedUser;

  void getCurrentUser(){
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
      }
    } catch (e){
      print(e);
    }
  }

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    CalendarPage(),
    NewHomePage(documentId: '',),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    //final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        //title: Text(user.email!),
        title: const Text('WaterMe'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications_active,
              semanticLabel: 'alarm',
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlarmPage()),
              );
            },
          ),
        ],
      ),
      


      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'MyPage',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreen,
        onTap: _onItemTapped,
      ),
    );
  }
}












