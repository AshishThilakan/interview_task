import 'package:flutter/material.dart';
import 'package:todo_crud_api/screens/todo_list.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     theme: ThemeData.dark(),
     home: const TodoListPage(),
   );
  }

}