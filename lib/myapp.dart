import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<String> items = [];

  TextEditingController controller = TextEditingController();

  void addItemToList() {
    setState(() {
      items.add(controller.text);
      _makeList();
      controller.clear();
    });
  }

  /*Future<void> _loadCounter() async {
   final prefs = await SharedPreferences.getInstance();
    setState(() {items = prefs.getStringList('items')?[];});
  }
*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadList();
  }

  Future<void> _loadList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
       items = (prefs.getStringList('list') ?? []);
    });
  }

  Future<void> _makeList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList('list', items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Materie'),
      ),
      body: Column(
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
    );
  }
}

//vedi tabview
