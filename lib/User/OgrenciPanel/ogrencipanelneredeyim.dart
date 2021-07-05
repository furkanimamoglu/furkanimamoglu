import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OgrenciPanelNeredeyim extends StatefulWidget {
  @override
  _OgrenciPanelNeredeyimState createState() => _OgrenciPanelNeredeyimState();
}

class _OgrenciPanelNeredeyimState extends State<OgrenciPanelNeredeyim> {
  Completer<GoogleMapController> haritaKontrol = Completer();

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      bulundugumKonum();
    });
  }

  List<Marker> haritaIsaretleri = <Marker>[];
  late Position suankiKonumum=Position(longitude: 29, latitude: 48, timestamp: DateTime(2020), accuracy: 100, altitude: 0, heading: 0, speed: 1, speedAccuracy: 1);
  var gidilecekYer = Marker(
      markerId: MarkerId("Id"),
      position: LatLng(40.9956986, 28.7232332),
      infoWindow: InfoWindow(
        title: "VeritabanindanCekilecek",
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("Öğrenci Panel - Neredeyim?"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: 400,
                height: 635,
                child: GoogleMap(
                  markers: Set<Marker>.of(haritaIsaretleri),
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
            ElevatedButton(
                onPressed: () {
                  final refDatabase =
                      FirebaseDatabase.instance.reference().child("uye_lokasyon");
                  var veriMap = Map<String, dynamic>();
                  veriMap["uye_durak_lat"] = suankiKonumum.latitude;
                  veriMap["uye_durak_lon"] = suankiKonumum.longitude;
                  refDatabase.update(veriMap);
                  var gidilecekYer = Marker(
                      markerId: MarkerId("Id"),
                      position: LatLng(
                          suankiKonumum.latitude, suankiKonumum.longitude),
                      infoWindow: InfoWindow(
                        title: "Evim",
                      ));
                  setState(() {
                    haritaIsaretleri.add(gidilecekYer);
                  });
                },
                child: Text(
                  "Burayı Ev Adresim Olarak Kaydet",
                  style: TextStyle(fontSize: 21),
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
