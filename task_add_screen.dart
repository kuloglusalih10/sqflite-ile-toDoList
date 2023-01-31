import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/db_helper.dart';
import '../models/task.dart';

class taskAdd extends StatefulWidget {

  @override
  State<taskAdd> createState() => _taskAddState();
}

class _taskAddState extends State<taskAdd> {
  dbHelper dbhelper = dbHelper();

  TextEditingController txtName = new TextEditingController();
  TextEditingController txtDescription = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Yeni Görev")
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              buildTextFormField_Name(),
              buildTextFormField_Description(),
              SizedBox(
                height: 20.0,
              ),
              buildSaveButton()
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

  buildSaveButton() {
    return ElevatedButton(onPressed: (){
      SaveTask();
    }, child: Text("Kaydet"));
  }

  void SaveTask() async{
    var result =await dbhelper.insert(task.idn(name :txtName.text,description :txtDescription.text));
    Navigator.pop(context,true);
  }
}
