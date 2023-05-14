import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'signin_widget.dart';
import 'model/product.dart';
import 'model/products_repository.dart';
import 'alarm.dart';
import 'enroll.dart';

class NewHomePage extends StatefulWidget{
  const NewHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NewHomePageState();
}

class NewHomePageState extends State<NewHomePage> {

  // Set<Product> products = favoriteList;
  // final hotels = favoriteList.toList();

  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
        body: Center(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Center(
                          child: Text(
                            //식물이름
                            'Puri',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                            ),
                            //textAlign: TextAlign.center,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        width: 100.0,
                        height: 35.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      //이미지 추가
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipOval(
                          child: Image.asset('assets/pot.png',
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                      SizedBox(width: 10), 
                      // 텍스트 추가
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10), 
                          Row(
                            children: [
                              Text(
                                'Temperature: ',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                //온도값
                                '25°C', 
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),     
                          Row(
                            children: [
                              Text(
                                'Water supply cycle : ',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                //주기
                                '14 days', 
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),     
                          Row(
                            children: [
                              Text(
                                'Soil humidity : ',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                //습도값
                                '70%', 
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 340),
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
    );
  }
}
