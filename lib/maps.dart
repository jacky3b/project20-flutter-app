import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsSample extends StatefulWidget {
  @override
  _MapsSampleState createState() => _MapsSampleState();
}

class _MapsSampleState extends State<MapsSample> {
  Map<MarkerId, Marker> _markers = Map<MarkerId, Marker>();
  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(10.7720817, 106.675066));
  MapType _defaultMapType = MapType.normal;

  GoogleMapController _controller;
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;

      // _isMapCreated = true;
      // if (widget.lat != null && widget.lat > 0) {
      drawMarker(LatLng(10.7720817, 106.675066));
      // }
    });
  }

  void drawMarker(LatLng _latLn) {
    final MarkerId markerId = MarkerId('1');
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        _latLn.latitude,
        _latLn.longitude,
      ),
    );

    setState(() {
      _markers[markerId] = marker;
    });
    if (_controller != null)
      _controller.moveCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: _latLn, zoom: 14)));
  }

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: Set<Marker>.of(_markers.values),
            mapType: _defaultMapType,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
          ),
          Container(
            margin: EdgeInsets.only(top: 80, right: 10),
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                    child: Icon(Icons.layers),
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    onPressed: () {
                      _changeMapType();
                      print('Changing the Map Type');
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
