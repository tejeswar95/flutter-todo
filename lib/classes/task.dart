class Task{
  int? id;
  String title="";
  String body="";

  Task({required this.title,this.body=''});


  String get _title => title ;
  String get _body => body;
  int get _id => id??0;
  set _title(String newtitle){
    this.title=newtitle;
  }
  set _body(String newbody){
    this.body=newbody;
  }

  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    map['title']=title;
    map['body']=body;
    map['id']=id;
    return map;

  }

  Task.fromMapObject(Map<String,dynamic> map){
    this.title=map['title'];
    this.body=map['body'];
    this.id=map['id'];
  }

}