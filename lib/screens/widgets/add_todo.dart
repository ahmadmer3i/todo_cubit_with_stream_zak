import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_with_stream/cubits/todo_list/todo_list_cubit.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final addTodoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: addTodoController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Add Todo',
      ),
      onSubmitted: (String? title) {
        if (title != null || title!.trim().isNotEmpty) {
          context.read<TodoListCubit>().addTodo(title: title);
          addTodoController.clear();
        }
      },
    );
  }

  @override
  void dispose() {
    addTodoController.dispose();
    super.dispose();
  }
}
