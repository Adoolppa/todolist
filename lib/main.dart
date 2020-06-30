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
        primarySwatch: Colors.cyan,
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

  Widget appBar()
  {
    return AppBar(
      title: Text('To do List'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search), onPressed: () { searchDialog(context);},
        ),
      ],
    );
  }

  Widget navigationDrawer()
  {
    return Drawer(
        child: ListView(
          children : <Widget> [
            ListTile(
              leading: Icon(Icons.account_box,
                color: Colors.blueGrey,
              ),
              title: Text('Account'),
              onTap: (){
              },
            ),
            ListTile(
              leading: Icon(Icons.menu,
                color: Colors.blueGrey,
              ),
              title: Text('Option'),
              onTap: (){
              },
            ),
          ],
        )
    );
  }

  Widget todoListBody() {
    return new ListView.builder(
        itemBuilder: (context, index) {
          if(index < todoList.length) {
            return listViewBuildToDoItem(todoList[index], index);
          }
        }
    );
  }

  Widget addTodo()
  {
    return new FloatingActionButton(
        onPressed: () { createInputDialog(context);},
        tooltip: 'Add',
        child: new Icon(Icons.add)
    );
  }

  Widget listViewBuildToDoItem(String todoText, int index) {
    return new ListTile(
      title: Text(todoText),
      trailing: IconButton(icon: Icon(Icons.check, color: Colors.blue,),
                onPressed: () => removeItem(index),)
    );
  }

  addItem(String item) {
    setState(() => todoList.add(item));
  }

  removeItem(int index) {
    setState(() => todoList.removeAt(index));
  }

  searchDialog(BuildContext context)  {
    TextEditingController customController = new TextEditingController();

    return showDialog(context: context, builder : (context){
      return AlertDialog (
        title : Text("Search To do"),
        content : TextField(
          controller: customController,
        ),
        actions: <Widget>[
          MaterialButton(
            elevation:5.0,
            child : Text('Search'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    }); // showDialog
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
            child : Text('Add'),
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
      appBar: appBar(),
      drawer: navigationDrawer(),
      body: todoListBody(),
      floatingActionButton: addTodo(),
    );
  }
}



