import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasimaprojesi/Functions/cikisYap.dart';
import 'package:tasimaprojesi/User/HostesPanel/hostespanelliste.dart';
import 'package:tasimaprojesi/User/HostesPanel/hostespanelsohbetler.dart';

import 'HostesPanel/hostespanelfatura.dart';
import 'HostesPanel/hostespanelkonum.dart';

class Hostes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("Hostes Paneli"),
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
                      MaterialPageRoute(
                          builder: (context) => HostesPanelListe()),
                    );
                  },
                  child: Image(
                      width: 100,
                      height: 100,
                      image: AssetImage("Images/list.png"))),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HostesPanelSohbetler()),
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
                          builder: (context) => HostesPanelKonum()),
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
                          builder: (context) => HostesPanelFatura()),
                    );
                  },
                  child: Image(
                      width: 100,
                      height: 100,
                      image: AssetImage("Images/Faturalar.png"))),
              ElevatedButton(onPressed: cikisYap, child: Text("Çıkış Yap"))
            ],
          )),
        ));
  }
}
