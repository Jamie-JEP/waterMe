import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class Enroll extends StatefulWidget {
  @override
  _EnrollState createState() => _EnrollState();
}

class _EnrollState extends State<Enroll> {
  //List<Card> cards = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _user;
  File? selectedFile;
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

  Future<void> uploadPhotoToFirebase(File file) async {
    if (file == null) return; // Return if no file is selected

    try {
      // Create a reference to the file in Firebase Storage
      final FirebaseStorage storage = FirebaseStorage.instance;
      final Reference storageRef = storage.ref().child('profile_photos').child('${_user?.uid}.jpg');

      // Upload the file to Firebase Storage
      await storageRef.putFile(file);

      // Get the download URL of the uploaded file
      final String downloadURL = await storageRef.getDownloadURL();

      // Do something with the downloadURL, such as storing it in the user's profile

      print('Photo uploaded successfully');
    } catch (e) {
      print('Error uploading photo: $e');
      // Handle the error
    }
  }

  Future<void> captureImage() async {
    // Code to capture a photo using the camera
    // Set the selectedFile to the captured image file
    // ...

    // Call the method to upload the photo to Firebase Storage
    await uploadPhotoToFirebase(selectedFile!);
  }

  Future<void> pickImageFromAlbum() async {
    // Code to select an image from the album
    // Set the selectedFile to the selected image file
    // ...

    // Call the method to upload the photo to Firebase Storage
    await uploadPhotoToFirebase(selectedFile!);
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
        .then((DocumentReference document) {
      print('Data saved to Firestore with ID: ${document.id}');
      final int newHomePageIndex=1;
      Navigator.pop(context);
      Navigator.push(
        context,
        //MaterialPageRoute(builder: (context) => NewHomePage(documentId: document.id)),
        MaterialPageRoute(
          builder: (context) => HomePage(),
          settings: RouteSettings(arguments: newHomePageIndex),
        ),
      );
    })
    // .then((value) => print('Data saved to Firestore'))
        .catchError((error) => print('Failed to save data: $error'));
  }




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
              onPressed: () async{
                saveDataToFirestore(name, waterCycle);
                await uploadPhotoToFirebase(selectedFile!);
                // Navigator.pop(context);

                Navigator.push(
                  context,
                  //MaterialPageRoute(builder: (context) => NewHomePage(documentId: '',)),
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}