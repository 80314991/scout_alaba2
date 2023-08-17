import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationApp extends StatefulWidget {
  const LocationApp({Key? key}) : super(key: key);

  @override
  State<LocationApp> createState() => _LocationAppState();
}

class _LocationAppState extends State<LocationApp> {
  var locationmassage = "";

  Future<void> gecurrentlocation() async {
    var position = await Geolocator.getCurrentPosition(desiredAccuracy : LocationAccuracy.high);
    var lastposition = await Geolocator.getLastKnownPosition();
    print(lastposition);
    setState(() {
      locationmassage= "${position.latitude} , ${position.longitude}";
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('location'),),
      body: Center(
        child: ElevatedButton(onPressed: (){gecurrentlocation();
          print(locationmassage);
          }, child: Text('location'),),
    ),);
  }
}
