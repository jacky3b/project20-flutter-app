import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

// final Color yellow = Color(0xfffbc31b);
// final Color orange = Color(0xfffb6900);

class UploadingImageToFirebaseStorage extends StatefulWidget {
  @override
  _UploadingImageToFirebaseStorageState createState() =>
      _UploadingImageToFirebaseStorageState();
}

class _UploadingImageToFirebaseStorageState
    extends State<UploadingImageToFirebaseStorage> {
  File _imageFile;
  final picker = ImagePicker();

  Future pickImage() async {
    // await doi minh chon xong r moi gan anh cho pickFile
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future pickImage1() async {
    // await doi minh chon xong r moi gan anh cho pickFile
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Container(
          //   height: 360,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.only(
          //           bottomLeft: Radius.circular(50.0),
          //           bottomRight: Radius.circular(50.0)),
          //       gradient: LinearGradient(
          //           colors: [orange, yellow],
          //           begin: Alignment.topLeft,
          //           end: Alignment.bottomRight)),
          // ),
          _imageFile != null
              ? Container(
                  margin: const EdgeInsets.only(top: 80),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Uploading Image to Firebase Storage",
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 28,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: double.infinity,
                              margin: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, top: 30.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Image.file(_imageFile)
                                  //  Column(
                                  //     children: [
                                  //       //2 button chup anh va up anh
                                  //       captureButton(context),
                                  //       gallaryButton(context),
                                  //     ],
                                  //   ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      uploadImageButton(context),
                    ],
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(top: 80),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Uploading Image to Firebase Storage",
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 28,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: double.infinity,
                              margin: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, top: 30.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: Column(
                                  children: [
                                    //2 button chup anh va up anh
                                    captureButton(context),
                                    gallaryButton(context),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

// chup hinh button
  Widget captureButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 40.0),
            margin: const EdgeInsets.only(
                top: 40.0, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                color: Colors.blue[200],
                // gradient: LinearGradient(
                //   colors: [yellow, orange],
                // ),
                borderRadius: BorderRadius.circular(30.0)),
            child: FlatButton(
              onPressed: () => pickImage(),
              child: Text(
                "Capture",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //gallary button
  Widget gallaryButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 40.0),
            margin: const EdgeInsets.only(
                top: 10.0, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                color: Colors.blue[200],
                // gradient: LinearGradient(
                //   colors: [yellow, orange],
                // ),
                borderRadius: BorderRadius.circular(30.0)),
            child: FlatButton(
              onPressed: () => pickImage1(),
              child: Text(
                "Gallery",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

//upload button
  Widget uploadImageButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 40.0),
            margin: const EdgeInsets.only(
                top: 30.0, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                // gradient: LinearGradient(
                //   colors: [yellow, orange],
                // ),
                borderRadius: BorderRadius.circular(30.0)),
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/location');
                uploadImageToFirebase(context);
              },
              child: Text(
                "Upload",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
