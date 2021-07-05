import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasimaprojesi/Widget/giristextfieldWidget.dart';
import 'package:tasimaprojesi/User/ogrenci.dart';
import 'package:tasimaprojesi/sifremiunuttum.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'Class/uyeler.dart';
import 'Functions/notificationAuth.dart';
import 'User/hostes.dart';
import 'User/veli.dart';
import 'Widget/showDialogWidget.dart';
import 'kayitol.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Disabling horizontal orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'Öğrenci Taşıma',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: MyHomePage(title: 'Öğrenci Taşıma'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_){
      girisYaptimMi();
      notificationAuth();
    });
  }

  Future<void> girisYaptimMi() async {
    var sp = await SharedPreferences.getInstance();
    if (sp.getInt("girisyapildipref") == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Hostes()),
      );
    } else if (sp.getInt("girisyapildipref") == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Ogrenci()),
      );
    } else if (sp.getInt("girisyapildipref") == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Veli()),
      );
    } else {}
  }

  /*
  Future _getThingsOnStartup() async {

  }
  */

  TextEditingController tcTextFieldController = TextEditingController();
  TextEditingController sifreTextFieldController = TextEditingController();
  int yetki = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text('Giriş Ekranı'),
      ),
      body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 175,
          height: 175,
          child: Image(image: AssetImage("Images/login.png")),
        ),
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
        GirisTextFieldWidget(sifreTextFieldController, "Şifre",true),
        ElevatedButton(
            onPressed: () {
              int tckimliknosayi = int.parse(tcTextFieldController.text);
              final refUye = FirebaseDatabase.instance
                  .reference()
                  .child("uye_tablo")
                  .orderByChild("uye_tc")
                  .equalTo(tckimliknosayi);
              refUye.once().then((DataSnapshot veri) {
                var cekilenDegerler = veri.value;
                if (cekilenDegerler != null) {
                  cekilenDegerler.forEach((key, nesne) async {
                    var cekilenUye = Uyeler.fromJson(nesne);

                    if (tckimliknosayi == cekilenUye.uyeTcDegisken &&
                        sifreTextFieldController.text ==
                            cekilenUye.uyePassDegisken) {
                      if (cekilenUye.uyeYetkiDegisken == 0 && yetki == 0) {
                        var sp = await SharedPreferences.getInstance();
                        sp.setInt("girisyapildipref", 0);
                        sp.setString("girisyapankullanicipref",tcTextFieldController.text);
                        sp.setString("girisyapankullanicikey",key);
                        print(sp.getString("girisyapankulanicikey"));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Hostes()),
                        );
                      } else if (cekilenUye.uyeYetkiDegisken == 1 &&
                          yetki == 1) {
                        var sp = await SharedPreferences.getInstance();
                        sp.setInt("girisyapildipref", 1);
                        sp.setString("girisyapankullanicipref",tcTextFieldController.text);
                        sp.setString("girisyapankullanicikey",key);
                        print(sp.getString("girisyapankulanicikey"));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Ogrenci()),
                        );
                      } else if (cekilenUye.uyeYetkiDegisken == 2 &&
                          yetki == 2) {
                        print("Yetkilendirme 2");
                        var sp = await SharedPreferences.getInstance();
                        sp.setInt("girisyapildipref", 2);
                        sp.setString("girisyapankullanicipref",tcTextFieldController.text);
                        sp.setString("girisyapankullanicikey",key);
                        print(sp.getString("girisyapankulanicikey"));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Veli()),
                        );
                      } else {
                        showDialogWidget.show(context,"Hatalı Kullanıcı Tipi","Kendinize ait bir kullanıcı tipi seçiniz. (Örnek: Hostes,Öğrenci,Veli)",
                                (){ Navigator.of(context).pop();});
                      }
                    } else {
                      showDialogWidget.show(context,"Hatalı Giriş","TC Kimlik No veya Şifrenizi yanlış girdiniz. Lütfen tekrar deneyiniz.",(){ Navigator.of(context).pop();});
                    }
                  });
                }
              });
            },
            child: Text("Giriş Yap")),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KayitOl()),
              );
            },
            child: Text("Kayıt Ol")),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SifremiUnuttum()),
            );
          },
          child: Text("Şifremi Unuttum"),
        )
      ])),
    );
  }
}

VoidCallback? popupKapat(context){
  Navigator.of(context).pop();
}