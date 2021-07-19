import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:todo/model/todo.dart';
import 'package:http/http.dart' as http;

class TodosProvider extends ChangeNotifier {
  //String _jsonResponse = "";

  List<Todo> _todos = [];

  TodosProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    //_isFetching = true;
    _todos.clear();
    notifyListeners();

    var response =
        await http.get(Uri.parse("http://192.168.0.165:8080/api/todos"));
    if (response.statusCode == 200) {
      print("Connection Success");
      var jsonData = jsonDecode(response.body);

      for (var i in jsonData) {
        Todo todo = Todo(
          id: i["id"],
          details: i["details"],
          status: i["status"],
        );
        _todos.add(todo);
      }

      notifyListeners();
    } else
      print("Connection failure");
  }

  Future<void> fetchSingle(int id) async {
    //_isFetching = true;

    var response =
        await http.get(Uri.parse("http://192.168.0.165:8080/api/todos/$id"));
    if (response.statusCode == 200) {
      print("Connection Success");
      var jsonData = jsonDecode(response.body);

      Todo todo = Todo(
        id: jsonData["id"],
        details: jsonData["details"],
        status: jsonData["status"],
      );

      _todos.add(todo);

      notifyListeners();
    } else
      print("Connection failure");
  }

  List<Todo> get todos => _todos.where((todo) => todo.status == false).toList();
  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.status == true).toList();

  void addTodo(Todo todo) async {
    var response = await http.post(
      Uri.parse("http://192.168.0.165:8080/api/todos"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(todo),
    );

    if (response.statusCode == 201) {
      //print(jsonDecode(response.body));
      print("Add Success");
      fetchSingle(todo.id);
    } else {
      print("Addition failed");
    }
  }

  void removeTodo(int id) async {
    var response = await http.delete(
      Uri.parse("http://192.168.0.165:8080/api/todos/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print("Delete Success");
      fetchData();
    } else {
      print("Delete failed");
    }
    notifyListeners();
  }

  void toggleTodoStatus(Todo todo) async {

    
    var response = await http.put(
      Uri.parse("http://192.168.0.165:8080/api/todos/${todo.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(todo),
    );

    if (response.statusCode == 200) {
      //print(jsonDecode(response.body));
      print("Toggle Success");
      fetchData();
    } else {
      print("Toggle failed");
    }
    notifyListeners();
    //return todo.status;
  }

  void updateTodo(Todo todo) async {
    var response = await http.put(
      Uri.parse("http://192.168.0.165:8080/api/todos/${todo.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(todo),
    );

    if (response.statusCode == 200) {
      //print(jsonDecode(response.body));
      print("Update Success");
      fetchData();
    } else {
      print("Update failed");
    }
    //todo.details = details;
    notifyListeners();
  }
}
