import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'signin_widget.dart';
import 'model/product.dart';
import 'model/products_repository.dart';



class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Alarm'),
        elevation: 0,
      ),
      body: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   color: Colors.indigoAccent[700],
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          // ),
          Card(
            elevation: 5,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10)),
              child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //SizedBox(width: 1,),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text('4/24',
                        style: TextStyle(fontWeight: FontWeight.w200,fontSize: 20, color:Colors.black),
                      ),
                    ),
                    Text("푸리 물주는 날"),
                    Icon(Icons.alarm_add),
                  ],
                  
                ),
            ),
          ),
          SizedBox(height: 10),
          Card(
            elevation: 5,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10)),
              child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //SizedBox(width: 1,),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text('4/24',
                        style: TextStyle(fontWeight: FontWeight.w200,fontSize: 20, color:Colors.black),
                      ),
                    ),
                    Text("푸리 물주는 날"),
                    Icon(Icons.alarm_add),
                  ],
                  
                ),
            ),
          ),
          SizedBox(height: 10),
          Card(
            elevation: 5,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10)),
              child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //SizedBox(width: 1,),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text('4/24',
                        style: TextStyle(fontWeight: FontWeight.w200,fontSize: 20, color:Colors.black),
                      ),
                    ),
                    Text("푸리 물주는 날"),
                    Icon(Icons.alarm_add),
                  ],
                  
                ),
            ),
          ),
        ],
      )),
    );
  }
}