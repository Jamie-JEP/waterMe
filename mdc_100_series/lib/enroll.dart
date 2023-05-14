import 'package:flutter/material.dart';
import 'package:shrine/home.dart';



// class Enroll extends StatelessWidget {
//   final _usernameController = TextEditingController();
//   final _formkey = GlobalKey<FormState>();

//   Widget build (BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child:Form(
//           key: _formkey,
//           child: ListView(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0),
//             children: <Widget>[
//               const SizedBox(height: 50.0),
//               imageProfile(),
//               const SizedBox(height: 12.0),
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: const InputDecoration(
//                   filled: true,
//                   labelText: '식물의 이름을 적어주세요.',
//                 ),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value ==null || value.isEmpty) {
//                     return '식물의 이름을 적어주세요!';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 12.0),
              
//               //const SizedBox(height: 20.0),
//               OverflowBar(
//                 alignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   ElevatedButton(
//                     child: const Text('Enrollment'),
//                     onPressed: () {
//                       if (_formkey.currentState!.validate()){
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => HomePage()),
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),   
//     );
//   }
// }


// bool validateStructure(String value){
//   String  pattern = r'^(?=.*?[a-zA-Z]{3,50})(?=.*?\d{3,50}).{6,}$';
//   RegExp regExp = new RegExp(pattern);
//   return regExp.hasMatch(value);
// }


// Widget imageProfile(BuildContext context) {
//   return Center(
//     child: Stack(
//       children:<Widget>[
//         // CircleAvatar(
//         //   radius:80,
//         //   backgroundImage :_imageFile==null
//         //     ? AssetImage('assets/waterme_logo.png')
//         //     : FileImage(File(_imageFile.path)),
//         // ),
//         Image.asset('assets/waterme_logo'),
//         Positioned(
//           bottom:20,
//           right:20,
//           child: InkWell(
//             onTap:(){
//               showModalBottomSheet(context:context, builder:((builder) => bottomSheet()));
//             },
//             child: Icon(
//               Icons.camera_alt,
//               color: Colors.blue,
//               size:40,
//             ),
//           )
//         )
//       ]
//     ),
//   ); 
// }





// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:my_flutter_example_app/constants/constants.dart';
// import 'package:my_flutter_example_app/widgets/widgets.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Enroll extends StatefulWidget {
  @override
  _EnrollState createState() => _EnrollState();
}

class _EnrollState extends State<Enroll> {
  //PickedFile? _imageFile;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();


  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Enroll your plant !'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric (vertical: 20, horizontal: 20),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 40),
            imageProfile(context),
            SizedBox(height: 60),
            nameTextField(),
            SizedBox(height: 20),
            speciesField()
          ],
        )
      )
    );
  }


  Widget imageProfile(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius:88,
            backgroundColor: Colors.green,
            child: CircleAvatar(
              radius: 80,
              backgroundImage: _imageFile == null
                ? AssetImage('assets/pot.png')
                : _imageFile!.path != null
                  ? FileImage(File(_imageFile!.path)) as ImageProvider<Object>?
                  : null,
            ),
          ),

                
          Positioned (
            bottom: 13,
            right: 13,
            child:Material(
              child: InkWell(
                onTap: () {
                  showModalBottomSheet (context: context, builder: ((builder) => bottomSheet(context)));
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.green,
                  size: 35,
                ),
              )
            ),
          )
        ],
      ),
    );
  }



  Widget nameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 2,
          ),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: 'Name',
        hintText: 'Input your name'
      ),
    );
  }


  bool _expanded = false;
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;

  Widget speciesField() {


    return ExpansionPanelList(
      animationDuration: Duration(milliseconds: 500),
      children: [
        ExpansionPanel(
          headerBuilder: (context, isExpanded) {
            return Row(
              children: [
                SizedBox(width: 20),
                Row(
                  children: [
                    Text(
                      "Filter",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                    SizedBox(width: 103.5),
                    Text(
                      "select filter",
                      style: TextStyle(
                          color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            );
          },

          body: Container(
            margin: EdgeInsets.only(left: 130),
            child: Column(
              children : <Widget> [
                Row(  
                  mainAxisAlignment: MainAxisAlignment.start,
                  children :[  
                    Transform.scale(
                      scale:1.5,
                      child:Checkbox(
                        value:_isChecked1,
                        onChanged: (value) {
                          setState(() {
                            _isChecked1 = value ?? false;
                          });
                        },
                      ),
                    ),
                    Text("No Kids Zone"),
                  ],
                ),
                Row(  
                  mainAxisAlignment: MainAxisAlignment.start,
                  children :[  
                    Transform.scale(
                      scale:1.5,
                      child:Checkbox(
                        value:_isChecked2,
                        onChanged: (value) {
                          setState(() {
                            _isChecked2 = value ?? false;
                          });
                        },
                      ),
                    ),
                    Text("Pet-Friendly"),
                  ],
                ),
                Row(  
                  mainAxisAlignment: MainAxisAlignment.start,
                  children :[  
                    Transform.scale(
                      scale:1.5,
                      child:Checkbox(
                        value:_isChecked3,
                        onChanged: (value) {
                          setState(() {
                            _isChecked3 = value ?? false;
                          });
                        },
                      ),
                    ),
                    Text("Free breakfast"),
                  ],
                ),
              ],
            ),
          ),
          isExpanded: _expanded,
          canTapOnHeader: true,
        ),
      ],
      expandedHeaderPadding: EdgeInsets.all(0),
      expansionCallback: (panelIndex, isExpanded) {
        _expanded = !_expanded;
        setState(() {

        });
      },
    );
  }

  void FlutterDialog() {
      String checkedItems = '';
      if (_isChecked1) {
        checkedItems += 'No Kids Zone\n';
      }
      if (_isChecked2) {
        checkedItems += 'Pet-Friendly\n';
      }
      if (_isChecked3) {
        checkedItems += 'Free breakfast\n';
      }
  }


  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 130,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Profile photo',
            style: TextStyle(fontSize: 29),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ElevatedButton.icon(
                icon: Icon(Icons.camera, size: 40,),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text('Camera', style: TextStyle(fontSize: 20)),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.photo_library, size: 40,),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text('Gallery', style: TextStyle(fontSize: 20)),
              )
            ],
          )
        ],
      )
    );
  }
    

  // takePhoto(ImageSource source) async {
  //   final pickedFile = await _picker.getImage(source: source);
  //   setState(() {
  //     _imageFile = pickedFile;
  //   });
  // }
  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }
}




