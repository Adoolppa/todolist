import 'package:flutter/material.dart';

final List<String> item = [];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'To Do'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  createInputDialog(BuildContext context)  {
    TextEditingController customController = new TextEditingController();

    return showDialog(context: context, builder : (context){
      return AlertDialog (
        title : Text("Add To Do"),
        content : TextField(
          controller: customController,
        ),
        actions: <Widget>[
          MaterialButton(
            elevation:5.0,
            child : Text('Submit'),
            onPressed: () {
              item.add(customController.text);
              },
          )
        ],
      );
    }); // showDialog
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BodyLayout(),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(child :
            Text('Add'),
              onPressed: () { createInputDialog(context);},
            ),
          FloatingActionButton(child :
          Text('Clear'),
            onPressed: () { item.clear();},
          ),
          ]
        ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

Widget _myListView(BuildContext context) {
  return ListView.builder(
    itemCount: item.length,
    itemBuilder: (context, index) {
      return ListTile(
          title: Text(item[index]),
      );
    },
  );
}

