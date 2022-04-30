import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_with_stream/cubits/active_todo_count/active_todo_count_cubit.dart';
import 'package:todo_cubit_with_stream/cubits/filtered_todo/filtered_todo_cubit.dart';
import 'package:todo_cubit_with_stream/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo_cubit_with_stream/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_cubit_with_stream/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo_cubit_with_stream/screens/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoListCubit>(
          create: (context) => TodoListCubit(),
        ),
        BlocProvider<ActiveTodoCountCubit>(
          create: (context) => ActiveTodoCountCubit(
            initialCount: context.read<TodoListCubit>().state.todos.length,
            todoListCubit: context.read<TodoListCubit>(),
          ),
        ),
        BlocProvider<TodoSearchCubit>(
          create: (context) => TodoSearchCubit(),
        ),
        BlocProvider<TodoFilterCubit>(
          create: (context) => TodoFilterCubit(),
        ),
        BlocProvider<FilteredTodoCubit>(
          create: (context) => FilteredTodoCubit(
            todoFilterCubit: context.read<TodoFilterCubit>(),
            filteredTodos: context.read<TodoListCubit>().state.todos,
            todoSearchCubit: context.read<TodoSearchCubit>(),
            todoListCubit: context.read<TodoListCubit>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Todo Cubit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodoScreen(),
      ),
    );
  }
}
