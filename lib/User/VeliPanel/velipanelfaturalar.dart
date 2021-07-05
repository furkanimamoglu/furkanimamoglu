import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasimaprojesi/Class/faturalar.dart';
import 'package:tasimaprojesi/User/VeliPanel/velipanelfaturaode.dart';

class VeliPanelFaturalar extends StatefulWidget {
  @override
  _VeliPanelFaturalarState createState() => _VeliPanelFaturalarState();
}

class _VeliPanelFaturalarState extends State<VeliPanelFaturalar> {
  List<Faturalar> faturaListesi = [];
  final refOgrenciler =
  FirebaseDatabase.instance.reference().child("uye_fatura");
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
    final refUye = FirebaseDatabase.instance.reference().child("uye_fatura");
    refUye.once().then((DataSnapshot veri) {
      Map<dynamic, dynamic> cekilenDegerler = Map<dynamic, dynamic>();
      cekilenDegerler = veri.value;
      if (cekilenDegerler != null) {
        cekilenDegerler.forEach((key, nesne) {
          var cekilenVeri = Faturalar.fromJson(nesne);
          setState(() {
            faturaListesi.add(cekilenVeri);
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
        title: Text("Veli Panel - Faturalar"),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: faturaListesi.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Icon(Icons.article_outlined, size: 75),
                ),
                Container(
                  child: Text(
                      "TC: ${faturaListesi[index].faturaTc}\nDurum: ${faturaListesi[index].faturaDurum}\nMiktar: ${faturaListesi[index].faturaMiktar} TL"),
                ),
                Container(
                  child:
                  ElevatedButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VeliPanelFaturaOde()),
                    );
                  }, child: Text("Ödeme Yap")),
                )
              ],
            );
          }),
    );
  }
}

class VeriCek {
  int faturaMiktarCek = 0;
  String faturaDurumCek = "Ödenmedi";
  int faturaTcCek = 0;
  String faturaKeyCek = "Key";

  void veriCekFonk() {
    final refUye = FirebaseDatabase.instance.reference().child("uye_fatura");
    refUye.once().then((DataSnapshot veri) {
      var cekilenDegerler = veri.value;
      if (cekilenDegerler != null) {
        cekilenDegerler.forEach((key, nesne) {
          var cekilenVeri = Faturalar.fromJson(nesne);
          faturaKeyCek = key;
          faturaTcCek = cekilenVeri.faturaTc;
          faturaDurumCek = cekilenVeri.faturaDurum;
          faturaMiktarCek = cekilenVeri.faturaMiktar;
        });
      }
    });
  }
}
