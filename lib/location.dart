import 'package:flutter/material.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  double lat = 10.7720817;
  double long = 106.675066;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Lat:$lat,Long:$long'),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 60.0,
                width: 120.0,
                child: RaisedButton(
                  color: Colors.teal,
                  shape: StadiumBorder(),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/map');
                  },
                  child: Text("Next"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
