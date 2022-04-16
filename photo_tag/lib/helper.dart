import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:toast/toast.dart';
//import 'package:path_provider/path_provider.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import 'firebase_config.dart';

class SecondScreenState extends State<SecondScreen> {
  File? _image;
  // List<String>? _labelTexts;
  bool _initialized = false;
  FirebaseApp? firebaseApp;

  // Define an async function to initialize FlutterFire
  Future<void> initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      firebaseApp = await Firebase.initializeApp(
          options: DefaultFirebaseConfig.platformOptions);
      _initialized = true;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    // _labelTexts = null;
    super.initState();
  }

  void _upload() async {
    if (!_initialized) {
      await initializeFlutterFire();
    }
    if (_image != null) {
      var uuid = Uuid();

      final String uid = uuid.v4();
      final String downloadURL = await _uploadFile(uid);
      await _addItem(downloadURL);
      //   Navigator.pop(context);
    }
  }

  Future getImage() async {
    if (!_initialized) {
      await initializeFlutterFire();
    }
    final ImagePicker _picker = ImagePicker();

    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
    // _labelTexts = null;
    setState(() {});
    // await detectLabels();
    setState(() {});
  }

  Future detectLabels() async {
    if (!_initialized) {
      await initializeFlutterFire();
    }
    // final FirebaseVisionImage visionImage =
    //     FirebaseVisionImage.fromFile(_image);
    // final ImageLabeler cloudLabeler =
    //     FirebaseVision.instance.cloudImageLabeler();

    // final List<ImageLabel> cloudLabels =
    //     await cloudLabeler.processImage(visionImage);
    // final TextRecognizer textRecognizer =
    //     FirebaseVision.instance.textRecognizer();
    // final VisionText visionText =
    //     await textRecognizer.processImage(visionImage);

    // String text = visionText.text;
    // for (TextBlock block in visionText.blocks) {
    //   final Rect boundingBox = block.boundingBox;
    //   final List<Offset> cornerPoints = block.cornerPoints;
    //   final String text = block.text;
    //   final List<RecognizedLanguage> languages = block.recognizedLanguages;
    //   print(text);

    //   for (TextLine line in block.lines) {
    //     // Same getters as TextBlock
    //     for (TextElement element in line.elements) {
    //       // Same getters as TextBlock
    //     }
    //   }
    // }

//    print(cloudLabels);

    // _labelTexts = new List();
    // for (ImageLabel label in cloudLabels) {
    //   final String text = label.text;
    //   final String entityId = label.entityId;
    //   final double confidence = label.confidence;
    //   print(text);
    //   _labelTexts.add(text + " " + confidence.toString());
    // }
  }

  Future<String> _uploadFile(filename) async {
    if (!_initialized) {
      await initializeFlutterFire();
    }
//    final File file = _image;
    final Reference ref = FirebaseStorage.instance.ref().child('$filename.jpg');
    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg', contentLanguage: 'en');
    final UploadTask uploadTask = ref.putFile(
      _image!,
      metadata,
    );

    final downloadURL = await (await uploadTask).ref.getDownloadURL();
    print(downloadURL);
    return downloadURL.toString();
  }

  Future<void> _addItem(String downloadURL) async {
    if (!_initialized) {
      await initializeFlutterFire();
    }
    await FirebaseFirestore.instance.collection('photos').add(<String, dynamic>{
      'downloadURL': downloadURL,
    });
  }

//   Widget getLabels() {
//     return ListView.builder(
//         padding: const EdgeInsets.all(8),
//         itemCount: _labelTexts!.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//             height: 25,
// //          color: Colors.amber[colorCodes[index]],
//             child: Center(child: Text('${_labelTexts![index]}')),
//           );
//         });
//   }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!, width: 300),
            // Container(
            //     margin: const EdgeInsets.all(10.0),
            //     height: 200.0,
            //     child: _labelTexts == null
            //         ? Text('No image selected.')
            //         : getLabels()),
            ElevatedButton(
              onPressed: () {
                _upload();
              },
              child: const Text('Submit', style: TextStyle(fontSize: 20)),
            )
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  SecondScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  SecondScreenState createState() => new SecondScreenState();
}
