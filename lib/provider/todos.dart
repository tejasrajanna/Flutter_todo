import 'package:flutter/cupertino.dart';
import 'package:todo/model/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [
    Todo(
      createdTime: DateTime.now(),
      title: 'Walk the dog',
    ),
    Todo(createdTime: DateTime.now(), title: 'Groceries', description: ''' 
-Eggs
-Milk
-Bread
-Flour'''),
    Todo(createdTime: DateTime.now(), title: 'Exercise', description: ''' 
-Push ups
-Treadmill
-Cycling'''),
    Todo(
      createdTime: DateTime.now(),
      title: 'Learn Flutter',
    ),
  ];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();
  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();
    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;
    notifyListeners();
  }
}
