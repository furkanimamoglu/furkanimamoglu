import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class VeliPanelFaturaOde extends StatefulWidget {
  @override
  _VeliPanelFaturaOdeState createState() => _VeliPanelFaturaOdeState();

}

class _VeliPanelFaturaOdeState extends State<VeliPanelFaturaOde> {
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Veli Panel - Fatura Öde"),
      ),
      body: SingleChildScrollView(
        child: Column(

        ),
      ),
    );
  }
}