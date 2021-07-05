import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class GirisTextFieldWidget extends StatelessWidget {
  String ?yazi;
  TextEditingController ?sifreTextFieldController;
  bool gizli=false;

  GirisTextFieldWidget(TextEditingController controller,String text,bool hidden){
    this.sifreTextFieldController = controller;
    this.yazi = text;
    this.gizli = hidden;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextField(
            controller: sifreTextFieldController,
            obscureText: gizli,
            obscuringCharacter: "*",
            decoration: InputDecoration(
              hintText: yazi,
              filled: true,
              hintStyle: TextStyle(fontStyle: FontStyle.italic),
              fillColor: Colors.white,
            )));
  }
}
