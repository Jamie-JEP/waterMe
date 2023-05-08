import 'package:flutter/material.dart';
import 'package:shrine/home.dart';
//import 


class Enroll extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ConfirmpasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Widget build (BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Form(
          key: _formkey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            children: <Widget>[
              const SizedBox(height: 50.0),
              imageProfile(),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: '식물의 이름을 적어주세요.',
                ),
                obscureText: true,
                validator: (value) {
                  if (value ==null || value.isEmpty) {
                    return '식물의 이름을 적어주세요!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              
              //const SizedBox(height: 20.0),
              OverflowBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text('Enrollment'),
                    onPressed: () {
                      if (_formkey.currentState!.validate()){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),   
    );
  }
}


bool validateStructure(String value){
  String  pattern = r'^(?=.*?[a-zA-Z]{3,50})(?=.*?\d{3,50}).{6,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}


Widget imageProfile() {
  return Center(
    child: Stack(
      children:<Widget>[
        // CircleAvatar(
        //   radius:80,
        //   backgroundImage :_imageFile==null
        //     ? AssetImage('assets/waterme_logo.png')
        //     : FileImage(File(_imageFile.path)),
        // ),
        Image.asset('assets/waterme_logo'),
        Positioned(
          bottom:20,
          right:20,
          child: InkWell(
            onTap:(){
              showModalBottomSheet(context:context, builder:((builder) => bottomSheet()));
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.blue,
              size:40,
            ),
          )
        )
      ]
    ),
  ); 
}





// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:my_flutter_example_app/constants/constants.dart';
// import 'package:my_flutter_example_app/widgets/widgets.dart';

// class Enroll extends Statefulwidget {
//   @override
//   _EnrollState createState() => _EnrollState();
// }

// class _EnrollState extends State<Enroll> {
//   PickedFile _imageFile; // H222 (image_picker)
//   final ImagePicker _picker = ImagePicker(); // H222 (image_picker)

//   @override
//   Widget build (BuildContext context) {
//     return Scaffold(
//       //appBar: appBarWidget('Regist Profile'),
//       body: Padding(
//         padding: const EdgeInsets.symmetric (vertical: 20, horizontal: 20),
//         child: ListView(
//           children: <Widget>[
//             imageProfile(),
//             SizedBox(height: 20),
//             nameTextField(),
//             SizedBox(height: 20),
//           ],
//         )
//       )
//     );
//   }

// Widget imageProfile() {
//   return Center(
//     child: Stack(
//       children: <Widget>[
//         // CircleAvatar(
//         //   radius: 80,
//         //   backgroundImage: _imageFile == null
//         //     ? AssetImage('assets/waterme_logo.png')
//         //     : FileImage(File(_imageFile.path)),
//         // ),

//         Image.asset('assets/waterme_logo.png', width: 300, fit: BoxFit.fill ),
              
//         Positioned (
//           bottom: 20,
//           right: 20,
//           child:Material(
//             child: InkWell(
//               onTap: () {
//                 showModalBottomSheet (context: context, builder: ((builder) => bottomSheet()));
//               },
//               child: Icon(
//                 Icons.camera_alt,
//                 color: Colors.blue,
//                 size: 40,
//               ),
//             )
//           ),
//         )
//       ],
//     ),
//   );
// }

// 

// Widget nameTextField() {
//   return TextFormField(
//     decoration: InputDecoration(
//       border: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: Colors.red,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: Colors.red,
//           width: 2,
//         ),
//       ),
//       prefixIcon: Icon(
//         Icons.person,
//         color: Colors.red,
//       ),
//       labelText: 'Name',
//       hintText: 'Input your name'
//     ),
//   );
// }
  
// Widget bottomSheet() {
//   return Container(
//     height: 100,
//     width: MediaQuery.of (context).size.width,
//     margin: EdgeInsets.symmetric(
//       horizontal: 20,
//       vertical: 20
//     ),
//     child: Column(
//       children: <widget>[
//         Text(
//           'Choose Profile photo',
//           style: Textstyle(font size: 29),
//         ),
//         SizedBox(height: 20,),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <widget>[
//             FlatButton.icon(
//               icon: Icon(Icons.camera, size: 50,),
//               onPressed: () {
//                 takePhoto(ImageSource.camera);
//               },
//               label: Text('Camera', style: Textstyle (fontsize: 20)),
//             ),
//             FlatButton.icon(
//               icon: Icon (Icons.photo_library, size: 50,),
//               onPressed: () {
//                 takePhoto(ImageSource.gallery);
//               },
//               label: Text('Gallery', style: Textstyle (fontsize: 20),),
//             )
//           ],
//         )
//       ],
//     )
//   );
// }
  
//   takePhoto(ImageSource source) async {
//     final pickedFile = await _picker.getImage(source: source);
//     setState(() {
//       _imageFile = pickedFile;
//     });
//   }
// }