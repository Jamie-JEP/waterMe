import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'homepage.dart';

class Enroll extends StatefulWidget {
  @override
  _EnrollState createState() => _EnrollState();
}

class _EnrollState extends State<Enroll> {
  //List<Card> cards = [];
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController waterCycleController = TextEditingController();

  String name = '';
  String waterCycle = '';

  @override
  void initState() {
    super.initState();
    nameController.addListener(updateName);
    waterCycleController.addListener(updateWaterCycle);
  }

  void updateName() {
    setState(() {
      name = nameController.text;
    });
  }

  void updateWaterCycle() {
    setState(() {
      waterCycle = waterCycleController.text;
    });
  }

  //firebase
  void saveDataToFirestore(String name, String waterCycle) {
    CollectionReference storedPlantCollection =
    FirebaseFirestore.instance.collection('storedPlant');

    storedPlantCollection
        .add({
      'name': name,
      'waterCycle': waterCycle,
    })
        .then((value) => print('Data saved to Firestore'))
        .catchError((error) => print('Failed to save data: $error'));
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

  Widget imageProfile(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 88,
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
          Positioned(
            bottom: 13,
            right: 13,
            child: Material(
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context, builder: ((builder) => bottomSheet(context)));
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.green,
                  size: 35,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget nameTextField() {
    return TextFormField(
      controller: nameController,
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
        hintText: 'Input your name',
      ),
    );
  }

  Widget waterCycleField() {
    return TextFormField(
      controller: waterCycleController,
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
          Icons.opacity,
          color: Colors.green,
        ),
        labelText: 'Water Cycle',
        hintText: "Input water cycle(days)",
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 130,
      width: MediaQuery
          .of(context).size.width,
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Column(
    children: <Widget>[
    Text(
    'Choose Profile photo',
    style: TextStyle
      (fontSize: 29),
    ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ElevatedButton.icon(
            icon: Icon(Icons.camera, size: 40),
            onPressed: () {
              takePhoto(ImageSource.camera);
            },
            label: Text('Camera', style: TextStyle(fontSize: 20)),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.photo_library, size: 40),
            onPressed: () {
              takePhoto(ImageSource.gallery);
            },
            label: Text('Gallery', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    ],
    ),
    );
  }

  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }



   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Enroll your plant!'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 40),
            imageProfile(context),
            SizedBox(height: 60),
            nameTextField(),
            SizedBox(height: 20),
            waterCycleField(),
            SizedBox(height: 80),
            ElevatedButton(
              child: Text("Enroll"),
              onPressed: () {
                saveDataToFirestore(name, waterCycle);
                //enrollButtonPressed('John Doe', 'johndoe@example.com');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewHomePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}







// import 'package:flutter/material.dart';
// import 'package:shrine/home.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// class Enroll extends StatefulWidget {
//   @override
//   _EnrollState createState() => _EnrollState();
// }
//
// class _EnrollState extends State<Enroll> {
//   //PickedFile? _imageFile;
//   XFile? _imageFile;
//   final ImagePicker _picker = ImagePicker();
//
//
//   @override
//   Widget build (BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Enroll your plant !'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric (vertical: 20, horizontal: 20),
//         child: ListView(
//           children: <Widget>[
//             SizedBox(height: 40),
//             imageProfile(context),
//             SizedBox(height: 60),
//             nameTextField(),
//             SizedBox(height: 20),
//             waterCycleField(),
//             SizedBox(height: 80),
//             ElevatedButton(child: Text("Enroll"), onPressed:(){
//               saveDataToFirestore(name, waterCycle);
//             }),
//           ],
//         )
//       )
//     );
//   }
//
//
//   Widget imageProfile(BuildContext context) {
//     return Center(
//       child: Stack(
//         children: <Widget>[
//           CircleAvatar(
//             radius:88,
//             backgroundColor: Colors.green,
//             child: CircleAvatar(
//               radius: 80,
//               backgroundImage: _imageFile == null
//                 ? AssetImage('assets/pot.png')
//                 : _imageFile!.path != null
//                   ? FileImage(File(_imageFile!.path)) as ImageProvider<Object>?
//                   : null,
//             ),
//           ),
//
//
//           Positioned (
//             bottom: 13,
//             right: 13,
//             child:Material(
//               child: InkWell(
//                 onTap: () {
//                   showModalBottomSheet (context: context, builder: ((builder) => bottomSheet(context)));
//                 },
//                 child: Icon(
//                   Icons.camera_alt,
//                   color: Colors.green,
//                   size: 35,
//                 ),
//               )
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController waterCycleController = TextEditingController();
//
//   String name = '';
//   String waterCycle = '';
//
//   @override
//   void initState() {
//     super.initState();
//     nameController.addListener(updateName);
//     waterCycleController.addListener(updateWaterCycle);
//   }
//
//   void updateName() {
//     setState(() {
//       name = nameController.text;
//     });
//   }
//
//   Widget nameTextField() {
//     return TextFormField(
//       controller: nameController,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.green,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.green,
//             width: 2,
//           ),
//         ),
//         prefixIcon: Icon(
//           Icons.person,
//           color: Colors.green,
//         ),
//         labelText: 'Name',
//         hintText: 'Input your name'
//       ),
//     );
//   }
//
//
//
//
//
//
//   void updateWaterCycle() {
//     setState(() {
//       name = waterCycleController.text;
//     });
//   }
//
//   Widget waterCycleField() {
//     return TextFormField(
//       controller: waterCycleController,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.green,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.green,
//             width: 2,
//           ),
//         ),
//         prefixIcon: Icon(
//           Icons.opacity,
//           color: Colors.green,
//         ),
//         labelText: 'Water Cycle',
//         hintText: "Input water cycle(days)"
//       ),
//     );
//   }
//
//   Widget bottomSheet(BuildContext context) {
//     return Container(
//       height: 130,
//       width: MediaQuery.of(context).size.width,
//       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: Column(
//         children: <Widget>[
//           Text(
//             'Choose Profile photo',
//             style: TextStyle(fontSize: 29),
//           ),
//           SizedBox(height: 20,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               ElevatedButton.icon(
//                 icon: Icon(Icons.camera, size: 40,),
//                 onPressed: () {
//                   takePhoto(ImageSource.camera);
//                 },
//                 label: Text('Camera', style: TextStyle(fontSize: 20)),
//               ),
//               ElevatedButton.icon(
//                 icon: Icon(Icons.photo_library, size: 40,),
//                 onPressed: () {
//                   takePhoto(ImageSource.gallery);
//                 },
//                 label: Text('Gallery', style: TextStyle(fontSize: 20)),
//               )
//             ],
//           )
//         ],
//       )
//     );
//   }
//
//   takePhoto(ImageSource source) async {
//     final pickedFile = await _picker.pickImage(source: source);
//     setState(() {
//       _imageFile = pickedFile;
//     });
//   }
// }
//
// void saveDataToFirestore(String name, String waterCycle) {
//   // Create a reference to the Firestore collection where you want to store the data
//   CollectionReference storedPlantCollection =
//   FirebaseFirestore.instance.collection('storedPlant');
//
//   // Create a new document in the collection
//   storedPlantCollection
//       .add({
//     'name': name,
//     'waterCycle': waterCycle,
//   })
//       .then((value) => print('Data saved to Firestore'))
//       .catchError((error) => print('Failed to save data: $error'));
// }
//
//
//
