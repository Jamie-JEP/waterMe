import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'login.dart';
import 'model/product.dart';
import 'model/products_repository.dart';

//캘린더 있고 체크화면있는 화면

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('check your waterMe'),
        centerTitle: true
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
            //여기에 캘린더랑 체크박스 들어갈 예정
            Text("dfdfdkjf"),
            Text("dfdfdkjfsdfsdfsdf"),
          ],
        ),
      ),
      


      
      resizeToAvoidBottomInset: false,
    );
  }
}