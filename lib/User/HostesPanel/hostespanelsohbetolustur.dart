import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasimaprojesi/Class/uyeler.dart';

import 'hostespanelmesaj.dart';

class HostesPanelSohbetOlustur extends StatefulWidget {
  @override
  _HostesPanelSohbetOlusturState createState() => _HostesPanelSohbetOlusturState();
}

class _HostesPanelSohbetOlusturState extends State<HostesPanelSohbetOlustur> {
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
          title: Text("Hostes Panel - Sohbet Oluştur"),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: uyeListesi.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        final refDatabase = FirebaseDatabase.instance.reference();
                        var sp = await SharedPreferences.getInstance();
                        refDatabase.child('uye_mesaj').child(sp.getString("girisyapankullanicikey")!).update({
                          'sohbet_tc':  uyeListesi[index].uyeTcDegisken,
                          'sohbet_isim': uyeListesi[index].uyeIsimDegisken,
                        });
                        sp.setString("sohbetkisi", "${uyeListesi[index].uyeTcDegisken}");
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
                                "${uyeListesi[index].uyeIsimDegisken}"),
                          ),
                        ],
                      ))
                ],
              );
            }));
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
