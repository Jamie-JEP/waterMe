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
import 'package:intl/intl.dart';
import 'login.dart';
import 'model/product.dart';
import 'model/products_repository.dart';
import 'alarm.dart';
import 'enroll.dart';


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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      
      // body: GridView.count(
      //   // crossAxisCount: 2,
      //   // padding: const EdgeInsets.all(16.0),
      //   // childAspectRatio: 8.0 / 9.0,
      //   //children: _buildGridCards(context),
      // ),

      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: Card(
                elevation: 5,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: Card(
                elevation: 5,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: Card(
                elevation: 5,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: Card(
                elevation: 5,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              child: const Text('새로운 식물 등록하기'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Enroll()),
                );
              },
            ),
          ],
        ),
      ),
      


      drawer: Drawer(
        child: ListView(
          //padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              padding: EdgeInsets.only(left:20, top: 100),
              child: Text('Pages',
              style: TextStyle(fontWeight: FontWeight.w500,fontSize: 30, color:Colors.white),
              ),
            ),
            ListTile(
              leading : Icon(Icons.home, color: Colors.green),
              title: const Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              leading : Icon(Icons.search, color: Colors.lightBlue),
              title: const Text('Search'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlarmPage()),
                );
              },
            ),
            ListTile(
              leading : Icon(Icons.location_city, color: Colors.lightBlue),
              title: const Text('Favorite Hotel'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            ListTile(
              leading : Icon(Icons.person, color: Colors.lightBlue),
              title: const Text('My page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            ListTile(
              leading : Icon(Icons.logout, color: Colors.lightBlue),
              title: const Text('Log Out'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

// class SearchPage extends StatelessWidget {

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sample Code'),
//       ),
//       body: Center(
//         child: Text('You have pressed the button $_count times.')),
//       backgroundColor: Colors.blueGrey.shade200,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => setState(() => _count++),
//         tooltip: 'Increment Counter',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }





// class AlarmPage extends StatefulWidget {
//   const AlarmPage({Key? key}) : super(key: key);

//   @override
//   State<AlarmPage> createState() => _AlarmPageState();
// }

// class _AlarmPageState extends State<AlarmPage> {
//   bool _expanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Alarm'),
//       ),
//       body: ListView(
        
//       ),

//     );
//   }
// }





