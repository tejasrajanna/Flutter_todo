import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/provider/todos.dart';
import 'package:todo/widget/todo_form_widget.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();
  String details = '';

  @override
  void initState() {
    super.initState();
    details = widget.todo.details;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Todo"),
        actions: [
          IconButton(
              onPressed: () {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);
                provider.removeTodo(widget.todo.id);
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: TodoFormWidget(
            details: details,
            onChangedDetails: (details) =>
                setState(() => this.details = details),
            onSavedTodo: saveTodo,
          ),
        ),
      ),
    );
  }

  void saveTodo() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TodosProvider>(context, listen: false);
      widget.todo.details = details;
      provider.updateTodo(widget.todo);
      Navigator.of(context).pop();
    }
  }
}
