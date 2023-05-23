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
  List<String> d = [];
  String testo = '';
  String desc = '';
  bool caricato = false;
  TextEditingController testoController = TextEditingController();
  TextEditingController descrizioneController = TextEditingController();

  Future<void> _loadList(int priorita, int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (priorita == 1) {
        p = (prefs.getStringList('listP1') ?? []);
        d = (prefs.getStringList('listD1') ?? []);

      } else {
        if (priorita == 2) {
          p = (prefs.getStringList('listP2') ?? []);
          d = (prefs.getStringList('listD2') ?? []);
        } else {
          p = (prefs.getStringList('listP3') ?? []);
          d = (prefs.getStringList('listD3') ?? []);
        }
      }
      title = p[index];
      testoController.text = title;
      desc = d[index];
      descrizioneController.text = desc;
    });
  }

  void editItemList(int priorita, int index) {
    setState(() {
      p[index] = testoController.text;
      d[index] = descrizioneController.text;
      _makeList(priorita);
    });
  }

  Future<void> _makeList(int priorita) async {
    final prefs = await SharedPreferences.getInstance();
    switch(priorita){
      case 1:
        prefs.setStringList('listP1', p);
        prefs.setStringList('listD1', d);
        break;
      case 2:
        prefs.setStringList('listP2', p);
        prefs.setStringList('listD2', d);
        break;
      case 3:
        prefs.setStringList('listP3', p);
        prefs.setStringList('listD3', d);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as Parametri;
    if(!caricato) {
      _loadList(args.p, args.index);
      caricato = true;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Dettaglio"),
        ),
        body: Center(
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: testoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Materia',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),

                    child: TextField(
                      controller: descrizioneController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Descrizione',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                editItemList(args.p, args.index);
              },
              child: const Text('Salva'),

            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(testo),
            )
          ]),
        ));
  }
}
