import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasimaprojesi/Functions/cikisYap.dart';

import 'VeliPanel/velipanelcocugumnerede.dart';
import 'VeliPanel/velipanelfaturalar.dart';
import 'VeliPanel/velipanelmesaj.dart';

class Veli extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("Veli Paneli"),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VeliPanelFaturalar()),
                    );
                  },
                  child: Image(
                      width: 100,
                      height: 100,
                      image: AssetImage("Images/list.png"))),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VeliPanelMesaj()),
                    );
                  },
                  child: Image(
                      width: 100,
                      height: 100,
                      image: AssetImage("Images/mesajlar.png"))),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VeliPanelCocugumNerede()),
                    );
                  },
                  child: Image(
                      width: 100,
                      height: 100,
                      image: AssetImage("Images/konum.png"))),
              ElevatedButton(onPressed: cikisYap, child: Text("Çıkış Yap"))
            ],
          )),
        ));
  }
}
