import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/db_helper.dart';
import '../models/task.dart';

class editTask extends StatefulWidget {

  task Task;
  editTask(this.Task);


  @override
  State<editTask> createState() => _editTaskState(Task);
}
enum options {delete,update}
class _editTaskState extends State<editTask> {

  var dbhelper = dbHelper();

  task Task;
  _editTaskState(this.Task);

  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();

  @override
  void initState() {
    txtName.text= Task.name;
    txtDescription.text = Task.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${Task.name} Görevi"),
          actions: <Widget>[

            PopupMenuButton<options>(
                onSelected: selectedProcess,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<options>>[

                  PopupMenuItem(
                      value: options.delete,
                      child: Text("Sil")
                  ),
                  PopupMenuItem(
                      value: options.update,
                      child: Text("Güncelle"))
                ])
          ],

        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              buildTextFormField_Name(),
              buildTextFormField_Description()
            ],
          ),
        )

    );
  }

  buildTextFormField_Name() {
    return TextField(
      decoration: InputDecoration(labelText: "Task Name"),
      controller: txtName,
    );

  }

  buildTextFormField_Description() {
    return TextField(
      decoration: InputDecoration(labelText: "Task Description"),
      controller: txtDescription,
    );
  }

  void selectedProcess(options value) async{
    switch(value)
    {
      case options.delete:
        print(Task.name);
        print(Task.id);
        await dbhelper.delete(Task.id!);
        Navigator.pop(context,true);
        break;
      case options.update:
        await dbhelper.update(task(Task.id,txtName.text,txtDescription.text));
        Navigator.pop(context,true);
        break;
      default:
    }

  }
}
