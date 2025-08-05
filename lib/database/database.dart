import 'package:hive/hive.dart';

class TodoDatabase {

  List TodoList=[];

final _mybox = Hive.box('mybox');

void CreatData(){

  TodoList=[

  ["TODO" , false],
 

  ];


}

void loadData(){


  TodoList=_mybox.get('TODOLIST');




}


void updateDataBase(){
  _mybox.put('TODOLIST', TodoList);
}







}