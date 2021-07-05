import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasimaprojesi/Class/faturalar.dart';

class HostesPanelFaturaOlustur extends StatefulWidget {
  @override
  _HostesPanelFaturaOlusturState createState() =>
      _HostesPanelFaturaOlusturState();
}

class _HostesPanelFaturaOlusturState extends State<HostesPanelFaturaOlustur> {
  List<Faturalar> faturaListesi = [];
  String durum="Ödendi";
  TextEditingController tcTextFieldController = TextEditingController();
  TextEditingController miktarTextFieldController = TextEditingController();

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        veriCekFonk();
      });
    });
  }

  void veriCekFonk() {
    final refUye = FirebaseDatabase.instance.reference().child("uye_fatura").limitToLast(1);
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
        title: Text("Hostes Panel - Fatura Oluştur"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          RadioListTile(
            title: Text("Ödendi"),
            value: "Ödendi",
            groupValue: durum,
            onChanged: (value) {
              setState(() {
                durum = "Ödendi";
              });
              print(durum);
            },
          ),
          RadioListTile(
            title: Text("Ödenmedi"),
            value: "Ödenmedi",
            groupValue: durum,
            onChanged: (value) {
              setState(() {
                durum = "Ödenmedi";
              });
              print(durum);
            },
          ),
          TextFormField(
            maxLength: 11,
            keyboardType: TextInputType.number,
            controller: tcTextFieldController,
            decoration: InputDecoration(
              hintText: "TC Kimlik No",
              filled: true,
              fillColor: Colors.orange[200],
            ),
          ),
          TextFormField(
            controller: miktarTextFieldController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Miktar",
              filled: true,
              fillColor: Colors.orange[200],
            ),
          ),
          ElevatedButton(onPressed: (){
            final refDatabase = FirebaseDatabase.instance.reference();

            refDatabase.child('uye_fatura').push().set({
              'uye_fatura_id' : faturaListesi[0].faturaID+1,
              'uye_fatura_durum': durum,
              'uye_fatura_miktar': int.parse(miktarTextFieldController.text),
              'uye_fatura_tc' : int.parse(tcTextFieldController.text),
            });
            Navigator.pop(context);
          }, child: Text("Fatura Oluştur"))
        ]),
      ),
    );
  }
}

