import 'package:flutter/material.dart';

class Descrizione extends StatefulWidget {
  const Descrizione({Key? key}) : super(key: key);

  @override
  State<Descrizione> createState() => _DescrizioneState();
}

class _DescrizioneState extends State<Descrizione> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dettaglio"),
        ),
        body: Text("ciao"));
  }
}
