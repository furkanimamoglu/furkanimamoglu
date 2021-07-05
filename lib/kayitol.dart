import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'Widget/giristextfieldWidget.dart';

class KayitOl extends StatefulWidget {
  @override
  _KayitOlState createState() => _KayitOlState();
}

class _KayitOlState extends State<KayitOl> {
  int yetki = 0;
  TextEditingController sifreTextFieldController = TextEditingController();
  TextEditingController mailTextFieldController = TextEditingController();
  TextEditingController tcTextFieldController = TextEditingController();
  TextEditingController isimsoyisimTextFieldController = TextEditingController();
  TextEditingController adresTextFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("Kayıt Ol"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ToggleSwitch(
                  initialLabelIndex: 0,
                  borderWidth: 10,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 3,
                  labels: ['Hostes', 'Öğrenci', 'Veli'],
                  onToggle: (index) {
                    yetki = index;
                  },
                ),
                GirisTextFieldWidget(tcTextFieldController, "TC Kimlik No",false),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp("[0-9]+"))
                  ],
                  controller: isimsoyisimTextFieldController,
                  decoration: InputDecoration(
                    hintText: "İsim Soyisim",
                    hintStyle: TextStyle(fontStyle: FontStyle.italic),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                GirisTextFieldWidget(adresTextFieldController, "Adres",false),
                GirisTextFieldWidget(mailTextFieldController, "Mail Adresiniz",false),
                GirisTextFieldWidget(sifreTextFieldController, "Şifre",false),
                ElevatedButton(
                    onPressed: () {
                      final refDatabase = FirebaseDatabase.instance.reference();
                      if (adresTextFieldController.text.isEmpty || isimsoyisimTextFieldController.text.isEmpty || sifreTextFieldController.text.isEmpty || tcTextFieldController.text.isEmpty)
                        {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => AlertDialog(
                                  title: Text("Eksik Kayıt"),
                                  content: Text(
                                      "Tüm bilgileri girdiğinizden emin olun."),
                                  actions: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(right: 100),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Tamam")))
                                  ]));
                        }
                      else {
                        refDatabase.child('uye_tablo').push().set({
                          'uye_yetki': yetki,
                          'uye_adres': adresTextFieldController.text,
                          'uye_durum': 1,
                          'uye_isim': isimsoyisimTextFieldController.text,
                          'uye_pass': sifreTextFieldController.text,
                          'uye_tc': tcTextFieldController.text,
                          'uye_mail': mailTextFieldController.text,
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Kayıt Ol")),
              ],
            ),
          ),
        ));
  }
}
