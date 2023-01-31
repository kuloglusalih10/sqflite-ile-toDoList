import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_todolist/screens/task_add_screen.dart';


import '../data/db_helper.dart';
import '../models/task.dart';
import 'edit_Task_Screen.dart';

final id_say=1;

class taskList extends StatefulWidget {


  @override
  State<taskList> createState() => _taskListState();
}

class _taskListState extends State<taskList> {

  dbHelper dbhelper = dbHelper();

  late List<task> tasks;
  int taskCount = 0;

  @override
  void initState() {
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Görev Listesi",),
      ),
      body: buildTaskList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(224,176,255,210),
        foregroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: (){
          goToTaskAdd();
        },
      ),
    );
  }

  buildTaskList() {
    return ListView.builder(
      itemCount: taskCount,
      itemBuilder: (BuildContext context,int index) {
        return Card(
          shadowColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(224,176,255,210)),
            borderRadius: const BorderRadius.all(Radius.circular(18))
          ),
          margin:EdgeInsets.all(10.0),
          elevation: 30.0,
          color: Color.fromARGB(224,176,255,210),
          child: ListTile(

            leading: CircleAvatar(
              child: Text((this.tasks[index].name).substring(0,1).toUpperCase(),
                            style: TextStyle(fontSize: 30.0,color: Colors.black)),
              maxRadius: 30.0,
              backgroundColor: Colors.yellowAccent
            ),
            title: Text(this.tasks[index].name.toUpperCase()),
            subtitle: Text((this.tasks[index].description),style: TextStyle(color: Colors.deepPurple),),
            onTap: (){
              goToTaskEdit(this.tasks[index]);
            },

          ),
        );
      },

    );

  }

  void getTasks() async{
    var taskFuture = dbhelper.getTasks();
    taskFuture.then((data) {
      setState(() {
        this.tasks =data;
        taskCount = data.length;
      });
    });

  }

  void goToTaskEdit(task Task) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context)=> editTask(Task)));
    if(result != null)
    {
      if(result)
      {
        setState(() {
          getTasks();
        });

      }
    }
  }

  goToTaskAdd() async {
    bool result =await  Navigator.push(context, MaterialPageRoute(builder: (context)=> taskAdd()));
    if(result != null)
    {
      if(result)
      {
        setState(() {
          getTasks();
        });

      }
    }
  }
}
