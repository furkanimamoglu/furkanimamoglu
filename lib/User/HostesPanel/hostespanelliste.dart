import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasimaprojesi/Class/uyeler.dart';

class HostesPanelListe extends StatefulWidget {
  @override
  _HostesPanelListeState createState() => _HostesPanelListeState();
}

class _HostesPanelListeState extends State<HostesPanelListe> {
  List<Uyeler> uyeListesi = [];
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
        .child("uye_tablo")
        .orderByChild("uye_tc");
    refUye.once().then((DataSnapshot veri) {
      Map<dynamic, dynamic> cekilenDegerler = Map<dynamic, dynamic>();
      cekilenDegerler = veri.value;
      if (cekilenDegerler != null) {
        cekilenDegerler.forEach((key, nesne) {
          var cekilenUye = Uyeler.fromJson(nesne);
          setState(() {
            uyeListesi.add(cekilenUye);
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
          title: Text("Hostes Panel - Öğrenci Listesi"),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: uyeListesi.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Container(
                    child: Icon(Icons.account_circle, size: 75),
                  ),
                  Container(
                    child: Text(
                        " İsim: ${uyeListesi[index].uyeIsimDegisken}\n TC: ${uyeListesi[index].uyeTcDegisken}\n Durum: ${uyeListesi[index].uyeDurumDegisken}\n Adres: ${uyeListesi[index].uyeAdresDegisken}"),
                  ),
                ],
              );
            })
    );
  }
}

class VeriCek {
  var uyeTcVeriCek = 0;
  String uyeIsimVeriCek = "placeholder";
  String uyePassVeriCek = "placeholder";
  String uyeAdresVeriCek = "placeholder";
  int uyeDurumVeriCek = 0;
  int uyeYetkiVeriCek = 0;

  void veriCekFonk() {
    final refUye = FirebaseDatabase.instance
        .reference()
        .child("uye_tablo")
        .orderByChild("uye_tc");
    refUye.once().then((DataSnapshot veri) {
      var cekilenDegerler = veri.value;
      if (cekilenDegerler != null) {
        cekilenDegerler.forEach((key, nesne) {
          var cekilenUye = Uyeler.fromJson(nesne);
          uyeIsimVeriCek = cekilenUye.uyeIsimDegisken;
          uyeTcVeriCek = cekilenUye.uyeTcDegisken;
          uyePassVeriCek = cekilenUye.uyePassDegisken;
          uyeAdresVeriCek = cekilenUye.uyeAdresDegisken;
          uyeDurumVeriCek = cekilenUye.uyeDurumDegisken;
          uyeYetkiVeriCek = cekilenUye.uyeYetkiDegisken;
        });
      }
    });
  }
}
