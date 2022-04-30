import 'package:flutter/material.dart';
import 'package:todo_cubit_with_stream/screens/widgets/add_todo.dart';
import 'package:todo_cubit_with_stream/screens/widgets/search_and_filter_todo.dart';
import 'package:todo_cubit_with_stream/screens/widgets/todo_header.dart';
import 'package:todo_cubit_with_stream/screens/widgets/todos_show.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  TodoHeader(),
                  AddTodo(),
                  SizedBox(
                    height: 10,
                  ),
                  SearchAndFilter(),
                  TodosShow(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
