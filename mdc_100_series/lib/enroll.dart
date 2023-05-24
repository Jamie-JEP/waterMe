import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
  String imageURL='';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController waterCycleController = TextEditingController();
  final TextEditingController codeController = TextEditingController();


  String name = '';
  String waterCycle = '';
  static int code = 0;

  @override
  void initState() {
    super.initState();
    nameController.addListener(updateName);
    waterCycleController.addListener(updateWaterCycle);
    //codeController.addListener(updateCode);
  }

  // Future<String> getLatestImageFileName() async {
  //   try {
  //     final listResult = await firebase_storage.FirebaseStorage.instance.ref('images/').listAll();
  //     final files = listResult.items;
  //     final latestFile = files.last;
  //     final fileMetadata = await latestFile.getMetadata();
  //     final fileName = fileMetadata.name;
  //
  //     final latestId = int.parse(fileName.split('.')[0]); // 파일 이름에서 숫자 부분 추출
  //     final newId = latestId + 1;
  //
  //     return '$newId';
  //   } catch (e) {
  //     print('가장 최근 이미지 파일 이름 가져오기 실패: $e');
  //     return '1'; // 기존 이미지가 없을 경우 기본 파일 이름으로 1 반환
  //   }
  // }
  Future<String> getLatestImageFileName() async {
    try {
      final listResult = await firebase_storage.FirebaseStorage.instance.ref('images/').listAll();
      final files = listResult.items;

      int latestId = -1;
      for (final file in files) {
        final fileName = file.name;
        final fileId = int.tryParse(fileName.split('.')[0]);
        if (fileId != null && fileId > latestId) {
          latestId = fileId;
        }
      }

      final newId = latestId + 1;

      return '$newId';
    } catch (e) {
      print('가장 최근 이미지 파일 이름 가져오기 실패: $e');
      return '1'; // 기존 이미지가 없을 경우 기본 파일 이름으로 1 반환
    }
  }

  Future<void> uploadImageToFirebase() async {
    if (_imageFile != null) {
      try {
        // 이미지 업로드

        // final fileName = '0.jpg';
        // final destination = 'images/$fileName';
        final fileName = await getLatestImageFileName(); // 가장 최근 이미지 파일 이름 가져오기
        final destination = 'images/$fileName.jpg';

        await firebase_storage.FirebaseStorage.instance
            .ref(destination)
            .putFile(File(_imageFile!.path));

        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref(destination).getDownloadURL();
        print(imageURL);

      } catch (e) {
        // 업로드 실패
        print('이미지 업로드 실패: $e');
      }
    } else {
      try {
        // 기본 이미지 업로드
        final defaultImagePath = 'assets/pot.jpg';
        final bytes = await File(defaultImagePath).readAsBytes();

        final latestId = await getLatestImageFileName(); // 가장 최근 이미지 파일 이름 가져오기
        final newId = int.parse(latestId) + 1;
        final fileName = '$newId.jpg';
        final destination = 'images/$fileName';

        await firebase_storage.FirebaseStorage.instance
            .ref(destination)
            .putData(bytes);
      } catch (e) {
        // 업로드 실패
        print('이미지 업로드 실패: $e');
      }
    }
  }

  Future<void> captureImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
        selectedFile = File(pickedFile.path);
      });
    }
  }

  Future<void> pickImageFromAlbum() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
        selectedFile = File(pickedFile.path);
      });
    }
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
  void saveDataToFirestore(String name, String waterCycle, int code, String imageURL) {
    CollectionReference storedPlantCollection =
    FirebaseFirestore.instance.collection('storedPlant');

    storedPlantCollection
        .add({
      'name': name,
      'waterCycle': waterCycle,
      'code': code,
      'image': imageURL
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

  Future<void> saveDataAndUploadImage() async {
    await uploadImageToFirebase(); // Wait for image upload to complete
    saveDataToFirestore(name, waterCycle, code, imageURL); // Save data to Firestore
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
                  ? AssetImage('assets/pot.jpg')
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
            'Choose plant photo',
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
                  captureImage();
                  Navigator.pop(context);
                },
                label: Text('Camera', style: TextStyle(fontSize: 20)),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.photo_library, size: 40),
                onPressed: () {
                  pickImageFromAlbum();
                  Navigator.pop(context);
                },
                label: Text('Gallery', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ],
      ),
    );
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
                saveDataAndUploadImage().then((_) {
                  code++;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }).catchError((error) {
                  // Handle any errors that occur during image upload or data saving
                  print('Error: $error');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}