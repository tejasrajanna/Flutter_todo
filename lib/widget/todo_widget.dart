import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/page/edit_todo_page.dart';
import 'package:todo/provider/todos.dart';

import '../utils.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  const TodoWidget({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
        //key: Key(todo.id),
        child: buildTodo(context),
        actionPane: SlidableDrawerActionPane(),
        actions: [
          IconSlideAction(
            color: Colors.green,
            onTap: () => editTodo(context, todo),
            caption: 'Edit',
            icon: Icons.edit,
          ),
        ],
        secondaryActions: [
          IconSlideAction(
            color: Colors.red,
            caption: 'Delete',
            onTap: () => deleteTodo(context, todo),
            icon: Icons.delete,
          )
        ],
      ),
    );
  }

  Widget buildTodo(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => editTodo(context, todo),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Checkbox(
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.white,
              value: todo.status,
              onChanged: (_) {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);
                todo.status = !todo.status;
                provider.toggleTodoStatus(todo);
                Utils.showSnackBar(
                  context,
                  todo.status ? 'Task Completed' : 'Task marked incomplete',
                );
              },
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                      todo.details,
                      style: TextStyle(fontSize: 20, height: 1.5),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo.id);

    Utils.showSnackBar(context, 'Deleted the task');
  }

  void editTodo(BuildContext context, Todo todo) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditTodoPage(todo: todo),
    ));
  }
}
