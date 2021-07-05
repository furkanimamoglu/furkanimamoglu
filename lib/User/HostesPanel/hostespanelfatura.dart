import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasimaprojesi/Class/faturalar.dart';
import 'package:tasimaprojesi/User/HostesPanel/hostespanelfaturaolustur.dart';

class HostesPanelFatura extends StatefulWidget {
  @override
  _HostesPanelFaturaState createState() => _HostesPanelFaturaState();
}

class _HostesPanelFaturaState extends State<HostesPanelFatura> {
  List<Faturalar> faturaListesi = [];
  final refFatura =
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
          cekilenVeri.addKey(key);
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
        title: Text("Hostes Panel - Faturalar"),
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
                      "ID: ${faturaListesi[index].faturaID}\nTC: ${faturaListesi[index].faturaTc}\nDurum: ${faturaListesi[index].faturaDurum}\nMiktar: ${faturaListesi[index].faturaMiktar} TL"),
                ),
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                          refFatura.child(faturaListesi[index].key).child("uye_fatura_durum").set("Ödendi");
                          setState(() {
                            faturaListesi[index].faturaDurum = "Ödendi";
                          });
                      },
                      child: Text("Onayla")),
                )
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HostesPanelFaturaOlustur()),
          );
        },
        elevation: 12,
        child: Icon(
          Icons.add,
          size: 40,
        ),
        backgroundColor: Colors.deepOrange,
        tooltip: "Fatura Ekle",
      ),
    );
  }
}

