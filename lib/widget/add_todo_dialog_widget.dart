import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/provider/todos.dart';
import 'package:todo/widget/todo_form_widget.dart';

class AddTodoDialogWidget extends StatefulWidget {
  const AddTodoDialogWidget({Key? key}) : super(key: key);

  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();

  String details = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Todo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 8),
            TodoFormWidget(
              onChangedDetails: (details) =>
                  setState(() => this.details = details),
              onSavedTodo: addTodo,
            )
          ],
        ),
      ),
    );
  }

  void addTodo() {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      print("Not valid");
      return;
    } else {
      print("Trying to add");
      final todo = Todo(
        id: provider.todos.length + 1,
        status: false,
        details: details,
      );

      provider.addTodo(todo);

      Navigator.of(context).pop();
    }
  }
}
