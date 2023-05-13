// // Future main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(WatermeApp());
// // }
// //
// // final navigatorKey = GlobalKey<NavigatorState>();
// class WatermeApp extends StatelessWidget{
//   const WatermeApp({Key? key}) : super(key: key);
//   static final String title = 'Fireabse Auth';
//
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//     //navigatorKey: navigatorKey,
//     debugShowCheckedModeBanner: false,
//     title: title,
//     theme: ThemeData(
//           useMaterial3: true,
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
//         ),
//     //initialRoute: '/login',
//     //routes: {
//     //    '/login': (BuildContext context) => const LoginWidget(),
//     //    '/': (BuildContext context) => const HomePage(),
//     //  },
//     //home: HomePage()
//   );
// }
//

// void main() => runApp(const WatermeApp());


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shrine/utils.dart';

import 'login.dart';
import 'home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(WatermeApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class WatermeApp extends StatelessWidget {
  const WatermeApp({Key? key}) : super(key: key);
  static final String title = 'Firebase Auth';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          } else if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginWidget();
          }
        },
      ),
    );
  }
}