import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OgrenciPanelMesaj extends StatefulWidget {
  @override
  _OgrenciPanelMesajState createState() => _OgrenciPanelMesajState();

}

class _OgrenciPanelMesajState extends State<OgrenciPanelMesaj> {
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Öğrenci Panel - Mesajlar"),
      ),
      body: SingleChildScrollView(
        child: Column(

        ),
      ),
    );
  }
}