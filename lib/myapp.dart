import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fase2ListView_SharedPreference',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> p1 = [];
  List<String> p2 = [];
  List<String> p3 = [];
  String _selection = "";

  TextEditingController controller = TextEditingController();

  void addItemToListP1() {
    setState(() {
      p1.add(controller.text);
      _makeList();
      controller.clear();
    });
  }

  void addItemToListP2() {
    setState(() {
      p2.add(controller.text);
      _makeList();
      controller.clear();
    });
  }

  void addItemToListP3() {
    setState(() {
      p3.add(controller.text);
      _makeList();
      controller.clear();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadList();
  }

  Future<void> _loadList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      p1 = (prefs.getStringList('listP1') ?? []);
      p2 = (prefs.getStringList('listP2') ?? []);
      p3 = (prefs.getStringList('listP3') ?? []);
    });
  }

  Future<void> _makeList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList('listP1', p1);
      prefs.setStringList('listP2', p2);
      prefs.setStringList('listP3', p3);
    });
  }

//sostituire nomi liste
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Text("Prima priorità")),
              Tab(icon: Text("Seconda priorità")),
              Tab(icon: Text("Terza priorità")),
            ],
          ),
          title: const Text('Tabs Demo'),
        ),
        body: TabBarView(
          children: [
            Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: p1.length,
                    itemBuilder: (context, index) {
                      return PopupMenuButton<String>(
                        onSelected: (String value) {
                          setState(() {
                            _selection = value;
                            switch(value){
                              case "UnoaDue":
                                p2.add(p1[index]);
                                p1.removeAt(index);
                                break;
                              case "UnoaTre":
                                p3.add(p1[index]);
                                p1.removeAt(index);
                                break;
                              case "eliminaUno":
                                p1.removeAt(index);
                                break;
                            }
                          });
                        },
                        child: ListTile(
                          title: Text('${p1[index]}'),
                        ),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'UnoaDue',
                            child: Text('Sposta in Seconda'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'UnoaTre',
                            child: Text('Sposta in Terza'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'eliminaUno',
                            child: Text('Elimina'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Inserisci la materia che desideri studiare',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: addItemToListP1,
                  child: Text('Aggiungi materia'),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: p2.length,
                    itemBuilder: (context, index) {
                      return PopupMenuButton<String>(
                        onSelected: (String value) {
                          setState(() {
                            _selection = value;
                            switch(value){
                              case "DueaUno":
                                p1.add(p2[index]);
                                p2.removeAt(index);
                                break;
                              case "DueaTre":
                                p3.add(p2[index]);
                                p2.removeAt(index);
                                break;
                              case "eliminaDue":
                                p2.removeAt(index);
                                break;
                            }
                          });
                        },
                        child: ListTile(
                          title: Text('${p2[index]}'),
                        ),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'DueaUno',
                            child: Text('Sposta in Prima'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'DueaTre',
                            child: Text('Sposta in Terza'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'eliminaDue',
                            child: Text('Elimina'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Inserisci la materia che desideri studiare',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: addItemToListP2,
                  child: Text('Aggiungi materia'),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: p3.length,
                    itemBuilder: (context, index) {
                      return PopupMenuButton<String>(
                        onSelected: (String value) {
                          setState(() {
                            _selection = value;
                            switch(value){
                              case "TreaUno":
                                p1.add(p3[index]);
                                p3.removeAt(index);
                                break;
                              case "TreaDue":
                                p2.add(p3[index]);
                                p3.removeAt(index);
                                break;
                              case "eliminaTre":
                                p3.removeAt(index);
                                break;
                            }
                          });
                        },
                        child: ListTile(
                          title: Text('${p3[index]}'),
                        ),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'TreaUno',
                            child: Text('Sposta in Prima'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'TreaDue',
                            child: Text('Sposta in Seconda'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'eliminaTre',
                            child: Text('Elimina'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Inserisci la materia che desideri studiare',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: addItemToListP3,
                  child: Text('Aggiungi materia'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
