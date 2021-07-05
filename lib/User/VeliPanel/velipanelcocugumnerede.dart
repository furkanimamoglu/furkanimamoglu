import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class VeliPanelCocugumNerede extends StatefulWidget {
  @override
  _VeliPanelCocugumNeredeState createState() => _VeliPanelCocugumNeredeState();

}

class _VeliPanelCocugumNeredeState extends State<VeliPanelCocugumNerede> {
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Veli Panel - Çocuğum Nerede"),
      ),
      body: SingleChildScrollView(
        child: Column(

        ),
      ),
    );
  }
}