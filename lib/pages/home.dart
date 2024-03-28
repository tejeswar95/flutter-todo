import 'package:flutter/material.dart';
import 'package:todolist/classes/task.dart';
import 'package:todolist/taskcard.dart';
import 'dart:async';
import 'package:todolist/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  DatabaseHelper databaseHelper=DatabaseHelper();
  int count=0;
  List<Task> data=[];
  // List<Task> data=[
  //   Task(title: 'hello',body: 'Important'),
  // ];

  @override
  Widget build(BuildContext context) {

    updateListView();

    return Scaffold(
      backgroundColor: const Color(0xff1A120B),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffD5CEA3),
        title: const Text('HOME'),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: data.map((e)=>TaskCard(
            data: e,
            delete: (){
              setState(() {
                //data.remove(e);
                _deleteTask(context, e);
                updateListView();
              });
            },
          )).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          try{
            dynamic res = await Navigator.pushNamed(context, '/create');
            setState(() async{
              //data.add(Task(title: res['title'],body: res['body']));
              await databaseHelper.insertTask(Task(title: res['title'],body: res['body']));
              updateListView();
            });
          }
          catch(e)
          {

          };
        },
        backgroundColor: const Color(0xffE5E5CB),
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  void _deleteTask(BuildContext context,Task task) async{
    await databaseHelper.deleteTask(task.title);
    updateListView();
  }

  void updateListView(){

    final Future<Database> dbFuture = databaseHelper.initialzeDatabase();
    dbFuture.then((database){
      Future<List<Task>> taskListFuture = databaseHelper.getTaskList();
      taskListFuture.then((taskList){
        setState(() {
          data=taskList;
          count=taskList.length;
        });
      });
    });
  }

}
