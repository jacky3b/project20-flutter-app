import 'package:flutter/material.dart';
import './upload.dart';
import './location.dart';
import './maps.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'land app',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: UploadingImageToFirebaseStorage(),
        routes: {
          '/upload': (_) => UploadingImageToFirebaseStorage(),
          '/location': (_) => Location(),
          '/map': (_) => MapsSample(),
        });
  }
}
