import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HostesPanelKonum extends StatefulWidget {
  @override
  _HostesPanelKonumState createState() => _HostesPanelKonumState();
}

class _HostesPanelKonumState extends State<HostesPanelKonum> {
  Completer<GoogleMapController> haritaKontrol = Completer();

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      bulundugumKonum();
    });
  }

  late Position suankiKonumum=Position(longitude: 29, latitude: 48, timestamp: DateTime(2020), accuracy: 100, altitude: 0, heading: 0, speed: 1, speedAccuracy: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("Hostes Panel - Konum"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: 400,
                height: 635,
                child: GoogleMap(
                  trafficEnabled: true,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          suankiKonumum.latitude, suankiKonumum.longitude),
                      zoom: 15),
                  onMapCreated: (GoogleMapController controller) {
                    haritaKontrol.complete(controller);
                  },
                )),
          ],
        )));
  }

  bulundugumKonum() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        suankiKonumum = position;
      });

    });
  }

}
