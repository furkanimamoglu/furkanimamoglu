import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OgrenciPanelDuraklar extends StatefulWidget {
  @override
  _OgrenciPanelDuraklarState createState() => _OgrenciPanelDuraklarState();

}

class _OgrenciPanelDuraklarState extends State<OgrenciPanelDuraklar> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Öğrenci Panel - Duraklar"),
      ),
      body: SingleChildScrollView(
        child: Column(

        ),
      ),
    );
  }
}