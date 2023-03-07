import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fase1ListView',
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
      controller.clear();
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