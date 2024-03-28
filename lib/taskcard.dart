import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/classes/task.dart';

class TaskCard extends StatelessWidget {

  final Task data;
  final Function() delete;

  TaskCard({required this.data,required this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      color: Color(0xffD5CEA3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 5, 0),
            child: Text(data.title,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5,child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color(0xff1A120B),),),),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,top: 8),
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(color: Color(0xffE5E5CB),borderRadius: BorderRadius.circular(10)),
                          child: Text(data.body),),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              IconButton(onPressed:delete,
                icon: Icon(Icons.check,color: Color(0xff1A120B),),iconSize: 40,)
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
