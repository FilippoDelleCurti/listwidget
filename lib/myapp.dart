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
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
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
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('${items[index]}'),
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
                  onPressed: addItemToList,
                  child: Text('Aggiungi materia'),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('${items[index]}'),
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
                  onPressed: addItemToList,
                  child: Text('Aggiungi materia'),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('${items[index]}'),
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
                  onPressed: addItemToList,
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

//vedi tabview

/*void main() {
  runApp(const TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
 */

/*Column(
children: <Widget>[
Expanded(
child: ListView.builder(
itemCount: items.length,
itemBuilder: (context, index) {
return ListTile(
title: Text('${items[index]}'),
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
onPressed: addItemToList,
child: Text('Aggiungi materia'),
),
],
),
*/
