import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:todolist/classes/task.dart';

class DatabaseHelper{

  static DatabaseHelper _databaseHelper=DatabaseHelper._createInstance();
  static Database? _database;

  String title='title';
  String body='body';
  String id ="id";

  DatabaseHelper._createInstance();

  factory DatabaseHelper(){
    if(_databaseHelper==null){
      _databaseHelper = DatabaseHelper._createInstance();
  }
    return _databaseHelper;
  }

  Future<Database> get  database async{
    if(_database==null){
      _database=await initialzeDatabase();
    }

    return _database!;

  }

  Future<Database> initialzeDatabase() async{
    Directory directory=await getApplicationDocumentsDirectory();
    String path = directory.path+'task.db';

    var tasksDatabase = await openDatabase(path,version: 1,onCreate: _createDb);
    return tasksDatabase;
  }

  //Create
  void _createDb(Database db,int newVersion) async{
    await db.execute('CREATE TABLE task($title TEXT,$body TEXT,$id )');
  }

  //Read
  Future<List<Map<String,dynamic>>>getTaskMapList() async{
    Database db= await this.database;
    var res= await db.rawQuery('SELECT * FROM task');
    return res;
  }

  //Insert
  Future<int> insertTask(Task task) async{
    Database db= await this.database;
    var res = await db.insert('task', task.toMap());
    return res;
  }

  //Update
  Future<int> updateTask(Task task) async{
    Database db= await this.database;
    var res = await db.update('task', task.toMap(),where: '$id = ?',whereArgs: [task.id] );
    return res;
  }

  //Delete
  Future<void> deleteTask(String deleteTitle) async{
    Database db= await this.database;
    var res = await db.delete('task',where: '$title = ?',whereArgs: [deleteTitle]);

  }

  //get count of the table
  Future<int> getCount() async{
    Database db= await this.database;
    List<Map<String,dynamic>> query = await db.rawQuery('SELECT COUNT (*) from task');
    int res = Sqflite.firstIntValue(query)??0;
    return res;
  }

  //Convert List<Map> to List<Task>
  Future<List<Task>> getTaskList() async{
    var taskMapList= await getTaskMapList();
    int len = taskMapList.length;

    List<Task> taskList = [];
    for(int i=0; i<len;i++){
      taskList.add(Task.fromMapObject(taskMapList[i]));
    }
    return taskList;
  }


}