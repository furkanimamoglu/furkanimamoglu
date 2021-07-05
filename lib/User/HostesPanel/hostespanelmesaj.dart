import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasimaprojesi/Class/mesajlar.dart';

class HostesPanelMesaj extends StatefulWidget {
  @override
  _HostesPanelMesajState createState() => _HostesPanelMesajState();
}

class _HostesPanelMesajState extends State<HostesPanelMesaj> {
  late String tc;
  final refMesaj = FirebaseDatabase.instance.reference().child("uye_mesaj");
  List<Mesajlar> mesajListesi = [];
  TextEditingController mesajKutusuController = TextEditingController();
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      veriCekFonk();
      var sp = await SharedPreferences.getInstance();
      tc = sp.getString("sohbetkisi")!;
    });
  }

  Future<void> veriCekFonk() async {
    var sp = await SharedPreferences.getInstance();
    final refMesaj = FirebaseDatabase.instance
        .reference()
        .child("uye_mesaj")
        .child(sp.getString("girisyapankullanicipref")!);
    refMesaj./* onChildAdded.listen((mesajlariGetir)) */once().then((DataSnapshot veri) {
      Map<dynamic, dynamic> cekilenDegerler = Map<dynamic, dynamic>();
      cekilenDegerler = veri.value;
      if (cekilenDegerler != null) {
        cekilenDegerler.forEach((key, nesne) {
          var cekilenVeri = Mesajlar.fromJson(nesne);
          cekilenVeri.addKey(key);
          if (cekilenVeri.mesajAliciTC ==
              sp.getString("girisyapankullanicipref")) {
            setState(() {
              mesajListesi.add(cekilenVeri);
            });
          } else {
            print("Mesaj Cekme Hata");
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Hostes Panel - Mesajlar"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: mesajListesi.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Row(
                              children: [
                                tc == mesajListesi[index].mesajGonderenTC ?
                                Container(margin: EdgeInsets.only(left: 275),child: Text("${mesajListesi[index].mesajIcerik}", style: TextStyle(fontSize: 20,),), color: Colors.orangeAccent,)
                                    :
                                Container(child: Text("${mesajListesi[index].mesajIcerik}", style: TextStyle(fontSize: 20,),), color: Colors.deepOrangeAccent,)
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                          child: Text(
                            "",
                            style: TextStyle(fontSize: 20),
                          ) // Boş Aralık
                      ),
                    ],
                  );
                }),),
            TextField(
                controller: mesajKutusuController,
                obscureText: false,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  hintText: "Bir mesaj yazın",
                  filled: true,
                  fillColor: Colors.white,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: () async {
                  final refDatabase = FirebaseDatabase.instance.reference();
                  var sp = await SharedPreferences.getInstance();
                  refDatabase.child('uye_mesaj').child("68398113986").push().set({
                    'mesaj_id' : mesajListesi[0].mesajID+1,
                    'mesaj_icerik': mesajKutusuController.text,
                    'mesaj_alicitc':  sp.getString("girisyapankullanicipref"),
                    'mesaj_gonderentc': sp.getString("girisyapankullanicipref"),
                    'mesaj_resim': "resimlink",
                  });
                }, child: Text("Gönder"),),
              ],
            )
          ],
        ),
      )
    );
  }
}

// var sp = await SharedPreferences.getInstance();
// print(sp.getString("girisyapankullanicipref"));


