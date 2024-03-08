// ignore_for_file: file_names, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:to_do/Constants/Colors.dart';
import 'package:to_do/Models/Todo.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem(
      {super.key,
      required this.todo,
      required this.onTodoChange,
      required this.onDeleteItem});

  final Todo todo;
  final onTodoChange;
  final onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTodoChange(todo);
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: White,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        leading: Icon(
          todo.isDone == true ? Icons.check_box : Icons.check_box_outline_blank,
          color: Blue,
          size: 24,
        ),
        title: Text(
          todo.ToDotext!,
          style: TextStyle(
              fontSize: 20,
              decoration:
                  todo.isDone == true ? TextDecoration.lineThrough : null,
              fontWeight: FontWeight.w500),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration:
              BoxDecoration(color: Red, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            onPressed: () {
              onDeleteItem(todo.id);
            },
            icon: const Icon(
              Icons.delete,
              color: White,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}
