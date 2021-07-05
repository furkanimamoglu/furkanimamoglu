import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class showDialogWidget{
  static show(BuildContext context,String mesajBaslik,String mesajIcerik,VoidCallback? callBack){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
        title: Text(mesajBaslik),
        content: Text(
            mesajIcerik),
        actions: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 100),
              child: ElevatedButton(
                  onPressed: () {
                    callBack!();
                  },
                  child: Text("Tamam")))
        ]));
  }


}




