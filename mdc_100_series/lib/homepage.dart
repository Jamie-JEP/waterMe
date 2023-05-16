import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import the Firestore package
import 'package:firebase_database/firebase_database.dart'; // Import the FirebaseDatabase package

import 'enroll.dart';

class NewHomePage extends StatefulWidget{
  final String documentId;
  const NewHomePage({Key? key, required this.documentId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NewHomePageState();
}

class NewHomePageState extends State<NewHomePage> {
  late String plantName = ''; // Initialize with an empty string
  late String waterCycle = ''; // Initialize with an empty string
  late String temperature ='';
  late String soilHumidity = '';


  List<Card> cards = [];
  List<DocumentSnapshot> plantDocuments = [];
  // Set<Product> products = favoriteList;
  // final hotels = favoriteList.toList();

  void initState() {
    super.initState();
    fetchPlantData(); // Fetch the plant data when the widget initializes
  }

  void fetchPlantData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('storedPlant')
          .get();
      
      List<DocumentSnapshot> newDocuments = snapshot.docs.where((doc) {
        // Filter out the documents that already exist in plantDocuments list
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

      List<String> documentIds = snapshot.docs.map((doc) => doc.id).toList();
      print('All document IDs: $documentIds');

      // DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
      //         .collection('storedPlant')
      //         .doc(widget.documentId)
      //         .get();

      // Access the 'ttest' node in Realtime Database
      DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('ttest');

      if (snapshot.docs.isNotEmpty) {
        var firstDocument = snapshot.docs.first;
        plantName = firstDocument.get('name') as String? ?? '';
        waterCycle = firstDocument.get('waterCycle') as String? ?? '';
      }

      //
      // plantName = snapshot.data()?['name'] ?? '';
      // waterCycle = snapshot.data()?['waterCycle'] ?? '';

      // Listen for a single value event
      reference.once().then((DatabaseEvent event) {
        DataSnapshot snapshot = event.snapshot;
        dynamic value = snapshot.value;
        if (value != null) {
          // Get the 'Temperature' and 'Soil Moisture' values from Realtime Database
          temperature = value['Temperature']?.toString() ?? '';
          soilHumidity = value['Soil Moisture']?.toString() ?? '';
          setState(() {});
        }
      }).catchError((error) {
        print('Error fetching plant data: $error');
      });

    } catch (e) {
      print('Error fetching plant data: $e');
    }
  }


  // void enrollButtonPressed(String name, String email) {
  //   // Create a new instance of the card widget and add it to the list
  //   Card newCard = Card(
  //     name: name,
  //     email: email,
  //   );
  //   setState(() {
  //     cards.add(newCard);
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
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
                  String waterCycle = plantDocument.get('waterCycle') as String? ?? '';

                
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 1),
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
                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              ),
                              width: 100.0,
                              height: 35.0,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
                                          //'25°C',
                                          temperature,
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
                                          //습도값
                                          //'70%',
                                          soilHumidity,
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
          SizedBox(height: 40),
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
    );
  }
}

