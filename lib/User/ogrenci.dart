import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasimaprojesi/Functions/cikisYap.dart';

import 'OgrenciPanel/ogrencipanelduraklar.dart';
import 'OgrenciPanel/ogrencipanelmesaj.dart';
import 'OgrenciPanel/ogrencipanelneredeyim.dart';

class Ogrenci extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Öğrenci Paneli"),
      ),
      body: SingleChildScrollView(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OgrenciPanelMesaj()),
                );
              },
              child: Image(
                  width: 100,
                  height: 100,
                  image: AssetImage("Images/mesajlar.png"))),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OgrenciPanelNeredeyim()),
                );
              },
              child: Image(
                  width: 100,
                  height: 100,
                  image: AssetImage("Images/konum.png"))),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OgrenciPanelDuraklar()),
                );
              },
              child: Image(
                  width: 100,
                  height: 100,
                  image: AssetImage("Images/bus.png"))),
          ElevatedButton(onPressed: cikisYap, child: Text("Çıkış Yap"))
        ],
      ))),
    );
  }
}
