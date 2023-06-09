import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
       SizedBox(height: 20,),
       ElevatedButton(onPressed: submitData,
           child: Text('Submit'),
       ),
        ],
      ),
    );
  }


 Future<void> submitData() async {
    //Get data from form
   final title = titleController.text;
   final description = descriptionController.text;
   final body = {
     "title": title,
     "description": description,
     "is_completed": false,
   };
   //submit data to the server
   final url = 'https://api.nstack.in/v1/todos';
   final uri = Uri.parse(url);
   final response = await http.post(uri,
       body: jsonEncode(body),
   headers: {'Content-Type': 'application/json'}
   );
   
   //show success or fail message based on status
   if(response.statusCode == 201){
     titleController.text = '';
   descriptionController.text = '';
     showSuccessMessage('Creation Sucess');
   }else{
     showErrorMessage('Creation Failed');
   print(response.body);
 }
}
void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

  void showErrorMessage(String message) {
    final snackBar = SnackBar(content: Text(message,
    style: TextStyle(color: Colors.red),
    ),
    backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
