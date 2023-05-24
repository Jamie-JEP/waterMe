import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'enroll.dart';
import 'home.dart';

class NewHomePage extends StatefulWidget {
  final String documentId;

  const NewHomePage({Key? key, required this.documentId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NewHomePageState();
}

class PlantData {
  final String code;
  final String plantName;
  final String waterCycle;
  final double humid;
  final double temp;
  final String photoUrl;

  PlantData({
    required this.code,
    required this.plantName,
    required this.waterCycle,
    required this.humid,
    required this.temp,
    required this.photoUrl,
  });
}

class NewHomePageState extends State<NewHomePage> {
  late String plantName = '';
  late String waterCycle = '';
  late String temperature1 = '';
  late String soilHumidity1 = '';
  late String temperature2 = '';
  late String soilHumidity2 = '';
  late int code = 100;

  List<Card> cards = [];
  List<DocumentSnapshot> plantDocuments = [];

  List<PlantData> plantDataList = [];

  void initState() {
    super.initState();
    fetchPlantData(); // Fetch the plant data when the widget initializes
  }

  Future<void> fetchPlantData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('storedPlant').get();

      List<DocumentSnapshot> newDocuments = snapshot.docs.where((doc) {
        return !plantDocuments.any((existingDoc) => existingDoc.id == doc.id);
      }).toList();

      if (newDocuments.isNotEmpty) {
        setState(() {
          plantDocuments.addAll(newDocuments);
        });
      }

      setState(() {
        plantDocuments = snapshot.docs;
      });


      DatabaseReference reference = FirebaseDatabase.instance.reference().child('test1');
      reference.once().then((DatabaseEvent event) {
        DataSnapshot snapshot = event.snapshot;
        dynamic value = snapshot.value;
        if (value != null) {
          temperature1 = value['Temperature']?.toString() ?? '';
          soilHumidity1 = value['Soil Moisture']?.toString() ?? '';
          setState(() {});
        }
      }).catchError((error) {
        print('Error fetching plant data: $error');
      });

      DatabaseReference reference2 = FirebaseDatabase.instance.reference().child('test2');
      reference2.once().then((DatabaseEvent event) {
        DataSnapshot snapshot = event.snapshot;
        dynamic value = snapshot.value;
        if (value != null) {
          temperature2 = value['Temperature']?.toString() ?? '';
          soilHumidity2 = value['Soil Moisture']?.toString() ?? '';
          setState(() {});
        }
      }).catchError((error) {
        print('Error fetching plant data: $error');
      });
    } catch (e) {
      print('Error fetching plant data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: plantDocuments.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot plantDocument = plantDocuments[index];
                  String plantName = plantDocument.get('name') as String? ?? '';
                  String waterCycle =
                      plantDocument.get('waterCycle') as String? ?? '';
                  String imageURL = plantDocument.get('image') as String? ?? '';
                  int code = plantDocument.get('code') as int? ?? 0;

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Center(
                                child: Text(
                                  //식물이름
                                  plantName,
                                  //'Puri',
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                              width: 100.0,
                              height: 35.0,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 15),
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
                                    child: Image.network(
                                      imageURL,
                                      //photoDownloadURL.toString(),
                                      width: 80,
                                      height: 80,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        // Handle the case when the photo fails to load
                                        return Image.asset(
                                          'assets/pot.jpg',
                                          width: 80,
                                          height: 80,
                                        );
                                      },
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
                                        Text(code.toString()),
                                        Text(
                                          'Temperature: ',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          //온도값
                                          //'25°C',
                                          code % 2 == 0 ? temperature1 : temperature2,
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
                                          waterCycle, //'14 days',
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
                                          (code % 2 == 0 ? double.tryParse(soilHumidity1)?.toStringAsFixed(2) : double.tryParse(soilHumidity2)?.toStringAsFixed(2)) ?? 'Invalid humidity',
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
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
            child: const Text('새로운 식물 등록하기'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Enroll()),
              );
            },
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
