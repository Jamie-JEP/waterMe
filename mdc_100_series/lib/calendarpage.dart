import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'signin_widget.dart';
import 'model/product.dart';
import 'model/products_repository.dart';
import 'alarm.dart';
import 'enroll.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:getwidget/getwidget.dart';

class CalendarPage extends StatefulWidget{
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CalendarPageState();
}
CalendarFormat _calendarFormat = CalendarFormat.week;
class CalendarPageState extends State<CalendarPage> {
  bool isChecked = false;

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
            ),
            SizedBox(height:30),
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
            SizedBox(height: 1,),
            GFCheckboxListTile(
              //이름변수
              titleText: 'plant name',
              subTitleText: 'watering day!',
              color: Colors.white,
              avatar: GFAvatar(
                //이미지 변수
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
                  isChecked = value;
                });
              },
              value: isChecked,
              inactiveIcon: null,
            ),
          ],
        ),
      ),
      
    );
  }
}
