import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_crud_api/screens/add_page.dart';
import 'package:http/http.dart' as http;

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = true;
  List items = [];


  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ToDo List'),
        ),
    body: Visibility(
      visible: isLoading,
      child: Center(
        child: CircularProgressIndicator(),
      ),
      replacement: RefreshIndicator(
        onRefresh: fetchTodo,

        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index] as Map;
          return ListTile(
            leading: CircleAvatar(
                child: Text('${index + 1}')),
            title: Text(item['title']),
            subtitle: Text(item['description']),
            trailing: PopupMenuButton(

                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        child: Text('Edit'),
                    value: 'edit',
                    ),
                    PopupMenuItem(
                        child: Text('Delete'),
                      value: 'delete',
                    ),
                  ];
                }),
          );
        }),
      ),
    ),
    floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: Text('Add Todo'),
    ),
    );
  }

  void navigateToAddPage() {

    final route = MaterialPageRoute(builder: (context) => AddTodoPage());
    Navigator.push(context, route);
  }

  Future<void> fetchTodo() async {
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    }
  setState(() {
    isLoading = false;
  });
  }
}
