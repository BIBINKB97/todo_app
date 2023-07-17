import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/model/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(
      {super.key,
      required this.todo,
      required this.onToDoChanged,
      required this.onDeleteItem});

  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListTile(
          onTap: () {
            onToDoChanged(todo);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          tileColor: Colors.white,
          leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: tdBlack,
          ),
          title: Text(
            todo.todoText!,
            style: TextStyle(
                fontSize: 18,
                color: tdBlack,
                fontWeight: FontWeight.w500,
                decoration: todo.isDone ? TextDecoration.lineThrough : null),
          ),
          trailing: CircleAvatar(
            backgroundColor: tdRed,
            radius: 22,
            child: IconButton(
              onPressed: () {
                onDeleteItem(todo.id);
              },
              icon: Icon(Icons.delete),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
