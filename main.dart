import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite_todolist/screens/task_list_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: taskList(),
    );
  }

}


