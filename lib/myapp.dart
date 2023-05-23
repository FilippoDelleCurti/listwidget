import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'Parametri.dart';

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

  _showPopupMenu1(Offset offset, int index) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem<String>(
          child: const Text('Sposta nella seconda priorità'),
          value: 'UnoaDue',
          onTap: () {
            setState(() {
              p2.add(p1[index]);
              p1.removeAt(index);
            });
          },
        ),
        PopupMenuItem<String>(
          child: const Text('Sposta nella terza priorità'),
          value: 'UnoaTre',
          onTap: () {
            setState(() {
              p3.add(p1[index]);
              p1.removeAt(index);
            });
          },
        ),
        PopupMenuItem<String>(
          child: const Text('Elimina'),
          value: 'eliminaUno',
          onTap: () {
            setState(() {
              p1.removeAt(index);
            });
          },
        )
      ],
      elevation: 8.0,
    );
  }

  _showPopupMenu2(Offset offset, int index) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem<String>(
          child: const Text('Sposta nella prima priorità'),
          value: 'DueaUno',
          onTap: () {
            setState(() {
              p1.add(p2[index]);
              p2.removeAt(index);
            });
          },
        ),
        PopupMenuItem<String>(
          child: const Text('Sposta nella terza priorità'),
          value: 'DueaTre',
          onTap: () {
            setState(() {
              p3.add(p2[index]);
              p2.removeAt(index);
            });
          },
        ),
        PopupMenuItem<String>(
          child: const Text('Elimina'),
          value: 'eliminaDue',
          onTap: () {
            setState(() {
              p2.removeAt(index);
            });
          },
        )
      ],
      elevation: 8.0,
    );
  }

  _showPopupMenu3(Offset offset, int index) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem<String>(
          child: const Text('Sposta nella prima priorità'),
          value: 'TreaUno',
          onTap: () {
            setState(() {
              p1.add(p3[index]);
              p3.removeAt(index);
            });
          },
        ),
        PopupMenuItem<String>(
          child: const Text('Sposta nella seconda priorità'),
          value: 'TreaDue',
          onTap: () {
            setState(() {
              p2.add(p3[index]);
              p3.removeAt(index);
            });
          },
        ),
        PopupMenuItem<String>(
          child: const Text('Elimina'),
          value: 'eliminaTre',
          onTap: () {
            setState(() {
              p3.removeAt(index);
            });
          },
        )
      ],
      elevation: 8.0,
    );
  }

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
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/Descrizione',
                            arguments: Parametri(
                              1,
                              index,
                            ),
                          ).then((_){
                            _loadList();
                          });
                        },
                        trailing: GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            _showPopupMenu1(details.globalPosition, index);
                          },
                          child: Container(
                            child: Icon(Icons.more_vert),
                          ),
                        ),
                        title: Text('${p1[index]}'),
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
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/Descrizione',
                            arguments: Parametri(
                              2,
                              index,
                            ),
                            ).then((_){
                              _loadList();
                          });
                        },
                        trailing: GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            _showPopupMenu2(details.globalPosition, index);
                          },
                          child: Container(
                            child: Icon(Icons.more_vert),
                          ),
                        ),
                        title: Text('${p2[index]}'),
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
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/Descrizione',
                            arguments: Parametri(
                              3,
                              index,
                            ),
                            ).then((_){
                              _loadList();
                            });
                        },
                        trailing: GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            _showPopupMenu3(details.globalPosition, index);
                          },
                          child: Container(
                            child: Icon(Icons.more_vert),
                          ),
                        ),
                        title: Text('${p3[index]}'),
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
