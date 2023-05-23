import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'signin_widget.dart';
import 'model/product.dart';
import 'model/products_repository.dart';
import 'alarm.dart';
import 'homepage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:getwidget/getwidget.dart';

class PlantData {
  String id;
  String name;
  String waterCycle;
  bool isChecked;

  PlantData({
    required this.id,
    required this.name,
    required this.waterCycle,
    this.isChecked = false,
  });
}

class CalendarPage extends StatefulWidget{
  final int soilHumidity;
  const CalendarPage({Key? key, required this.soilHumidity}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CalendarPageState();
}

CalendarFormat _calendarFormat = CalendarFormat.week;

class CalendarPageState extends State<CalendarPage> {
  bool isChecked = false;
  bool isWatered = false;

  //List<DocumentSnapshot> filteredDocuments =[];
  List<PlantData> plantDataList = [];

  Color calculateCircleColor() {
    int checkedCount = plantDataList.where((plantData) => plantData.isChecked).length;
    if (checkedCount == plantDataList.length) {
      return Colors.green; // 모든 체크박스가 체크된 경우
    } else {
      double progress = checkedCount / plantDataList.length;
      return Color.lerp(Colors.blue, Colors.green, progress)!; // 점진적으로 색상 변경
    }
  }

  void showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Good job!'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchPlantData();
  }

  void fetchPlantData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('storedPlant').get();

      // 필터링 작업 수행
      List<PlantData> newPlantDataList = snapshot.docs.where((doc) {
        int waterCycle = int.tryParse(doc.get('waterCycle') as String? ?? '') ?? 0;
        return widget.soilHumidity < 15;
      }).map((doc) {
        return PlantData(
          id: doc.id,
          name: doc.get('name') as String? ?? '',
          waterCycle: doc.get('waterCycle') as String? ?? '',
        );
      }).toList();

      setState(() {
        plantDataList = newPlantDataList;
      });

      // ...

    } catch (e) {
      print('Error fetching plant data: $e');
    }
  }
  // Set<Product> products = favoriteList;
  // final hotels = favoriteList.toList();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child:Column(
          children:[
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),

              calendarFormat: _calendarFormat,
              availableCalendarFormats: const {
                CalendarFormat.month: 'month',
                CalendarFormat.week: 'week',
              },
              
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },

              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: calculateCircleColor().withOpacity(0.5),
                  shape: BoxShape.circle)
              ),
            ),
            SizedBox(height:20),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Center(
                          child: Text(
                            'Water to Me!',
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
                        width: 140.0,
                        height: 40.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height:5),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: plantDataList.length,
                itemBuilder: (context, index) {
                  PlantData plantData = plantDataList[index];

                  return GFCheckboxListTile(
                    titleText: plantData.name,
                    subTitleText: 'watering day!',
                    color: Colors.white,
                    avatar: GFAvatar(
                      backgroundImage: AssetImage('assets/pot.png'),
                    ),
                    size: 26,
                    activeBgColor: Colors.green,
                    type: GFCheckboxType.basic,
                    activeIcon: Icon(
                      Icons.check,
                      size: 20,
                      color: Colors.white,
                    ),
                    onChanged: (value) {
                      setState(() {
                        plantData.isChecked = value;
                        showSnackbar();
                        //isWatered=value;
                      });
                    },
                    value: plantData.isChecked,
                    inactiveIcon: null,
                  );
                },
              ),
            ),
            if (plantDataList.isEmpty)
              Text('No data available'),
                
            // Column(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(left: 15.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           Container(
            //             child: Center(
            //               child: Text(
            //                 'Water to Me!',
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 16,
            //                     color: Colors.white,
            //                 ),
            //                 //textAlign: TextAlign.center,
            //               ),
            //             ),
            //             decoration: BoxDecoration(
            //                 color: Colors.green,
            //                 borderRadius: BorderRadius.all(Radius.circular(12.0)),
            //             ),
            //             width: 140.0,
            //             height: 40.0,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 1,),
            // GFCheckboxListTile(
            //   //이름변수
            //   titleText: 'plant name',
            //   subTitleText: 'watering day!',
            //   color: Colors.white,
            //   avatar: GFAvatar(
            //     //이미지 변수
            //     backgroundImage: AssetImage('assets/pot.png'),
            //   ),
            //   size: 26,
            //   activeBgColor: Colors.green,
            //   type: GFCheckboxType.basic,
            //   activeIcon: Icon(
            //     Icons.check,
            //     size: 20,
            //     color: Colors.white,
            //   ),
            //   onChanged: (value) {
            //     setState(() {
            //       isChecked = value;
            //       isWatered = value;
            //     });
            //   },
            //   value: isChecked,
            //   inactiveIcon: null,
            // ),
          ],
        ),
      ),
      
    );
  }
}
