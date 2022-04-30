import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_with_stream/cubits/filtered_todo/filtered_todo_cubit.dart';
import 'package:todo_cubit_with_stream/cubits/todo_list/todo_list_cubit.dart';

class TodosShow extends StatefulWidget {
  const TodosShow({Key? key}) : super(key: key);

  @override
  State<TodosShow> createState() => _TodosShowState();
}

class _TodosShowState extends State<TodosShow> {
  final editTodoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var todos = context.watch<FilteredTodoCubit>().state.filteredTodos;
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(todos[index].id),
          background: setBackgroundColor(1),
          secondaryBackground: setBackgroundColor(0),
          onDismissed: (_) {
            context.read<TodoListCubit>().deleteTodo(todo: todos[index]);
          },
          confirmDismiss: (_) {
            return showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('Do you want to delete this item?'),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ],
              ),
            );
          },
          child: ListTile(
            onTap: () {
              editTodoController.text = todos[index].title;
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('Edit Todo'),
                  content: CupertinoTextField(
                    controller: editTodoController,
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      child: const Text(
                        'Edit',
                        style: TextStyle(color: Colors.green),
                      ),
                      onPressed: () {
                        if (editTodoController.text.isNotEmpty ||
                            editTodoController.text.trim().isNotEmpty) {
                          context.read<TodoListCubit>().editTodo(
                              id: todos[index].id,
                              title: editTodoController.text);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
            leading: Checkbox(
              onChanged: (bool? value) {
                context.read<TodoListCubit>().toggleTodo(id: todos[index].id);
              },
              value: todos[index].isCompleted,
            ),
            title: Text(todos[index].title),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        color: Colors.grey,
      ),
      itemCount: todos.length,
    );
  }

  Widget setBackgroundColor(int direction) {
    return Container(
      alignment: direction == 0 ? Alignment.centerRight : Alignment.centerLeft,
      color: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  @override
  void dispose() {
    editTodoController.dispose();
    super.dispose();
  }
}
