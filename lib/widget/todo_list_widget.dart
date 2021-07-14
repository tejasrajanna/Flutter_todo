import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/todos.dart';
import 'package:todo/widget/todo_widget.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;

    return todos.isEmpty
        ? Center(
            child: Text(
              'No todos.',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16),
      separatorBuilder: (context, index) => Container(height: 8,),
        itemBuilder: (context, index) {
          final todo = todos[index];
          return TodoWidget(todo: todo);
        },
        itemCount: todos.length
        );
  }
}
