import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import 'package:todo/database/database.dart';

import 'package:todo/utils/dialog_box.dart';

import 'package:todo/utils/todo_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();

  final _myBox = Hive.box('mybox');

  TodoDatabase db = TodoDatabase();

  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      db.CreatData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  // List TodoList=[
  //    ["TODO" , false],
  //    ["TODO" , false],
  //    ["TODO" , false],
  //    ["TODO" , false],
  //    ["TODO" , false],
  //    ["TODO" , false],

  // ];

  void deleteTask(int index) {
    setState(() {
      db.TodoList.removeAt(index);
    });
    db.updateDataBase();
  }

  void CheckboxChanged(bool? value, int index) {
    setState(() {
      db.TodoList[index][1] = !db.TodoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.TodoList.add([_controller.text, false]);
      _controller.clear();
      Navigator.of(context).pop();
    });
    db.updateDataBase();
  }

  void creatNewtask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          Controller: _controller,
          onCancle: () => Navigator.of(context).pop(),
          onSave: saveNewTask,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 189, 169, 227),
      appBar: AppBar(
        title: const Text('TODO'),
        backgroundColor: const Color.fromARGB(255, 131, 89, 204),

        elevation: 10,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: creatNewtask,
        child: const Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: db.TodoList.length,

        itemBuilder: (context, index) {
          return TodoItem(
            isChecked: db.TodoList[index][1],
            onChanged: (value) => CheckboxChanged(value, index),
            todoText: db.TodoList[index][0],
            onPressed: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
