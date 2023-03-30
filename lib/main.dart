import 'package:flutter/material.dart';
import 'package:todo_list/model/todo_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Todo list'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController _todoItemTextFieldController = TextEditingController();

  final List<TodoItem> _todoList = [
    TodoItem(name: 'Build flutter app'),
    TodoItem(name: 'Get some milk', isClear: true),
    TodoItem(name: 'Tweet about progress'),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _addNewItem(String taskName) {
    setState(() {
      _todoList.add(TodoItem(name: taskName));
    });
  }

  void _deleteItem(int itemIndex){
    setState(() {
      _todoList.removeAt(itemIndex);
    });
  }

  void _negateItemStatus(int itemIndex){
    setState(() {
      _todoList[itemIndex] = _todoList[itemIndex].copyWith(isClear: !_todoList[itemIndex].isClear);
    });
  }

  void _openDeletePrompt(int itemIndex){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Are you sure you wanto to delete?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              _deleteItem(itemIndex);
              Navigator.pop(context);
            },
          ),
        ],
      );
    });
  }

  void _openAddItemDialog(){
    _todoItemTextFieldController.clear();
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Add new todo item'),
        content: TextField(
          controller: _todoItemTextFieldController,
          decoration: InputDecoration(hintText: "Type your new todo"),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Add'),
            onPressed: () {
              _addNewItem(_todoItemTextFieldController.text);
              Navigator.pop(context);
            },
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _todoList.length ?? 0,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(
              _todoList[i].name,
              style: TextStyle(
                decoration: _todoList[i].isClear ? TextDecoration.lineThrough : TextDecoration.none,
                color: _todoList[i].isClear ? Colors.grey : Colors.black,
              ),
            ),
            leading: CircleAvatar(
              child: Text(_todoList[i].name.substring(0, 1)),
            ),
            onTap: (){
              _negateItemStatus(i);
            },
            onLongPress: (){
              _openDeletePrompt(i);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddItemDialog,
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
