import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';



class dbHelper{
  var _db;


  Future<Database> get db async {

    if(_db == null)
    {
      _db= await initalize_db();
    }

    return _db;

  }


  Future<Database>  initalize_db() async{

    String dbPath = join(await getDatabasesPath(),"task.db");
    var taskdb = await openDatabase(dbPath,version: 1,onCreate: create_db);
    return taskdb;
  }



  void create_db(Database db, int version) async{
    await db.execute("CREATE table tasks (id integer primary key AUTOINCREMENT NOT NULL , name text , description text)");
  }

  Future<List<task>> getTasks() async{

    Database db = await this.db;

    var result = await db.query("tasks");
    return List.generate(result.length, (index) {
      return task.fromJson(result[index]);
    });

  }

  Future<int> insert (task Task) async{
    Database db = await this.db ;

    var result = await db.insert("tasks", Task.toJson());
    return result;

  }

  Future<int> delete(int id) async{
    Database db = await this.db;
    var result = await db.rawDelete("delete from tasks where id= $id");
    return result;
  }

  Future<int> update(task Task) async {
    Database db = await this.db ;
    var result = await db.update("tasks",Task.toJson() ,where: "id =?" ,whereArgs: [Task.id]);
    return result;
  }





}