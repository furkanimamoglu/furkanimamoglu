import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasimaprojesi/Widget/showDialogWidget.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'Widget/giristextfieldWidget.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class SifremiUnuttum extends StatefulWidget {
  @override
  _SifremiUnuttumState createState() => _SifremiUnuttumState();
}

class _SifremiUnuttumState extends State<SifremiUnuttum> {
  TextEditingController tcController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  int yetki = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("Şifremi Unuttum"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GirisTextFieldWidget(tcController, "TC Giriniz", false),
                GirisTextFieldWidget(mailController, "Mail Adresinizi Giriniz", false),
                ElevatedButton(
                    onPressed: () async {
                      var url = Uri.parse('http://furkanimamoglu.com.tr/index.php?key=-MdpgJxV7S_3WopxFKxa&uyemailget=${mailController.text}&uyetcget=${tcController.text}');
                      var response = await http.post(url, body: {});
                      if(response.statusCode==200)
                        {
                          showDialogWidget.show(context, "İşlem Başarılı", "Şifreniz: ${response.body}", () {
                            Navigator.pop(context);
                          });
                        }
                      else{
                        showDialogWidget.show(context, "Hata", "Şifreniz gönderilemedi.", () {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Text("Gönder"))
              ],
            ),
          ),
        ));
  }
}
