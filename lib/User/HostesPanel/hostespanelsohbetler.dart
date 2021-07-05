import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasimaprojesi/Class/sohbetler.dart';
import 'package:tasimaprojesi/User/HostesPanel/hostespanelsohbetolustur.dart';

import 'hostespanelmesaj.dart';

class HostesPanelSohbetler extends StatefulWidget {
  @override
  _HostesPanelSohbetlerState createState() => _HostesPanelSohbetlerState();
}

class _HostesPanelSohbetlerState extends State<HostesPanelSohbetler> {
  List<Sohbetler> sohbetListesi = [];
  final refOgrenciler =
      FirebaseDatabase.instance.reference().child("uye_tablo");
  final refDatabase = FirebaseDatabase.instance.reference();

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        veriCekFonk();
      });
    });
  }

  void veriCekFonk() {
    final refUye = FirebaseDatabase.instance
        .reference()
        .child("uye_mesaj");
    refUye.once().then((DataSnapshot veri) {
      Map<dynamic, dynamic> cekilenDegerler = Map<dynamic, dynamic>();
      cekilenDegerler = veri.value;
      if (cekilenDegerler != null) {
        cekilenDegerler.forEach((key, nesne) {
          var cekilenSohbet = Sohbetler.fromJson(nesne);
          setState(() {
            sohbetListesi.add(cekilenSohbet);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("Hostes Panel - Sohbetler"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HostesPanelSohbetOlustur()),
            );
          },
          elevation: 12,
          child: Icon(
            Icons.add,
            size: 40,
          ),
          backgroundColor: Colors.deepOrange,
          tooltip: "Mesaj Yaz",
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: sohbetListesi.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HostesPanelMesaj()),
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.account_circle, size: 75),
                          ),
                          Container(
                            width: 269,
                            child: Text(
                                "${sohbetListesi[index].sohbetIsim}"),
                          ),
                        ],
                      ))
                ],
              );
            }));
  }
}

class VeriCek {
  var sohbetTCDegiskenVeriCek = 0;
  String sohbetIsimDegiskenVeriCek = "placeholder";

  void veriCekFonk() {
    final refUye = FirebaseDatabase.instance
        .reference()
        .child("uye_mesaj");
    refUye.once().then((DataSnapshot veri) {
      var cekilenDegerler = veri.value;
      if (cekilenDegerler != null) {
        cekilenDegerler.forEach((key, nesne) {
          var cekilenSohbet = Sohbetler.fromJson(nesne);
          sohbetIsimDegiskenVeriCek = cekilenSohbet.sohbetIsim;
          sohbetTCDegiskenVeriCek = cekilenSohbet.sohbetTC;
        });
      }
    });
  }

}
