import 'package:flutter/material.dart';
import 'dart:async';
import 'package:todolist/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class create extends StatefulWidget {
  const create({super.key});

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {

  late TextEditingController titleCtrl;
  //TODO:Write Priorities
  List<String> labels=['Important','ASAP','Low','High'];
  String? data='Low';

  DatabaseHelper helper = DatabaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleCtrl=TextEditingController();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffE5E5CB),
        title: Text('Create Task'),
      ),
      body: Container(
        color: Color(0xff3C2A21),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:30.0),
                  child: TextField(decoration: InputDecoration(fillColor: Color(0xff1A120B),filled: true,
                    label: Text('Title: '),labelStyle: TextStyle(color: Color(0xffE5E5CB)),
                  ),
                    style: TextStyle(color: Color(0xffE5E5CB)),
                    controller: titleCtrl,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  // child:
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 20,),
                      Text('Label: ',style: TextStyle(color: Color(0xffE5E5CB)),),
                      SizedBox(width: 20,),
                      DropdownButton(
                        dropdownColor: Color(0xff1A120B),
                        style: TextStyle(color: Color(0xffE5E5CB), ),
                        items: labels.map((String items){
                          return DropdownMenuItem<String>(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        value: data,
                        onChanged: (val){
                          setState(() {
                            data=val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xff1A120B),),
                margin: EdgeInsets.all(20),
                child: IconButton(onPressed: (){
                  Navigator.pop(context, {
                    'title': titleCtrl.text,
                    'body': data,
                  });
                }, icon: Icon(Icons.save),color: Color(0xffD5CEA3),iconSize: 40,)),
          ],
        ),
      ),
    );
  }

}
