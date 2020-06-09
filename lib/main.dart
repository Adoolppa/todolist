import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoList(title: 'To Do'),
    );
  }
}

class TodoList extends StatefulWidget {
  TodoList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends State<TodoList> {

  List<String> todoList = [];

  Widget todoListBody() {
    return new ListView.builder(
        itemBuilder: (context, index) {
          if(index < todoList.length) {
            return listViewBuildToDoItem(todoList[index], index);
          }
        }
    );
  }

  Widget listViewBuildToDoItem(String todoText, int index) {
    return new ListTile(
      title: Text(todoText),
      onTap: () => removeItem(index),
    );
  }

  addItem(String item) {
    setState(() => todoList.add(item));
  }

  removeItem(int index) {
    setState(() => todoList.removeAt(index));
  }

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
              addItem(customController.text);
              Navigator.pop(context);
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
      body: todoListBody(),
      floatingActionButton: new FloatingActionButton(
          onPressed: () { createInputDialog(context);},
          tooltip: 'Add',
          child: new Icon(Icons.add)
      ),
    );
  }
}



