import 'package:Fase1Listview/Parametri.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Descrizione extends StatefulWidget {
  const Descrizione({Key? key}) : super(key: key);

  @override
  State<Descrizione> createState() => _DescrizioneState();
}

class _DescrizioneState extends State<Descrizione> {
  String title = "";
  List<String> p = [];

  Future<void> _loadList(int priorita, int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (priorita == 1) {
        p = (prefs.getStringList('listP1') ?? []);
      } else {
        if (priorita == 2) {
          p = (prefs.getStringList('listP2') ?? []);
        } else {
          p = (prefs.getStringList('listP3') ?? []);
        }
      }
      title = p[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Parametri;
    _loadList(args.p, args.index);
    return Scaffold(
      appBar: AppBar(
        title: Text("Dettaglio"),
      ),
      body: Text(title),
      /*Container(
        margin: EdgeInsets.all(20),
        child: TextField(
          controller: testopesoController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Peso (kg)...',
          ),
        ),
      ),*/
    );
  }
}
