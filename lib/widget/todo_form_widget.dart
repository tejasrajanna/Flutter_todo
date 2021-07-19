import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  
  final String details;
  final ValueChanged<String> onChangedDetails;
  final VoidCallback onSavedTodo;

  const TodoFormWidget({
    Key? key,
    this.details = '',
    required this.onChangedDetails,
    required this.onSavedTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildDetails(),
        SizedBox(
          height: 32,
        ),
        buildButton(),
      ],
    )
    );
  }

  // Widget buildTitle() => TextFormField(
  //       maxLines: 1,
  //       initialValue: title,
  //       onChanged: onChangedTitle,
  //       validator: (title) {
  //         if (title!.isEmpty) {
  //           return 'Title cannot be empty';
  //         }
  //         return null;
  //       },
  //       decoration: InputDecoration(
  //         border: UnderlineInputBorder(),
  //         labelText: 'Title',
  //       ),
  //     );

  Widget buildDetails() => TextFormField(
        maxLines: 3,
        initialValue: details,
        onChanged: onChangedDetails,
        validator: (details) {
          if (details!.isEmpty) {
            return 'Details cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Details',
        ),
      );

  Widget buildButton() => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
        onPressed: onSavedTodo,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
        ),
        child: Text('Save')
        ),
  );

}
