import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class VeliPanelMesaj extends StatefulWidget {
  @override
  _VeliPanelMesajState createState() => _VeliPanelMesajState();

}

class _VeliPanelMesajState extends State<VeliPanelMesaj> {
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Veli Panel - Mesajlar"),
      ),
      body: SingleChildScrollView(
        child: Column(

        ),
      ),
    );
  }
}