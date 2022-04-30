import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_cubit_with_stream/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo_cubit_with_stream/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_cubit_with_stream/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo_cubit_with_stream/models/todo_model.dart';

part 'filtered_todo_state.dart';

class FilteredTodoCubit extends Cubit<FilteredTodoState> {
  late StreamSubscription todoListSubscription;
  late StreamSubscription searchTodoSubscription;
  late StreamSubscription todoFilterSubscription;

  final TodoListCubit todoListCubit;
  final TodoSearchCubit todoSearchCubit;
  final TodoFilterCubit todoFilterCubit;

  final List<Todo> filteredTodos;

  FilteredTodoCubit(
      {required this.todoFilterCubit,
      required this.filteredTodos,
      required this.todoSearchCubit,
      required this.todoListCubit})
      : super(FilteredTodoState(filteredTodos: filteredTodos)) {
    searchTodoSubscription =
        todoSearchCubit.stream.listen((TodoSearchState todoSearchState) {
      setTodoFilter();
    });
    todoListSubscription =
        todoListCubit.stream.listen((TodoListState todoListState) {
      setTodoFilter();
    });
    todoFilterSubscription =
        todoFilterCubit.stream.listen((TodoFilterState todoFilterState) {
      setTodoFilter();
    });
  }

  void setTodoFilter() {
    List<Todo> _filteredTodo;
    switch (todoFilterCubit.state.filter) {
      case Filter.active:
        _filteredTodo = todoListCubit.state.todos
            .where((Todo todo) => !todo.isCompleted)
            .toList();
        break;
      case Filter.completed:
        _filteredTodo = todoListCubit.state.todos
            .where((Todo todo) => todo.isCompleted)
            .toList();
        break;
      case Filter.all:
      default:
        _filteredTodo = todoListCubit.state.todos;
        break;
    }
    if (todoSearchCubit.state.searchText.isNotEmpty) {
      _filteredTodo = todoListCubit.state.todos
          .where((Todo todo) => todo.title
              .toLowerCase()
              .contains(todoSearchCubit.state.searchText))
          .toList();
    }
    emit(state.copyWith(filteredTodos: _filteredTodo));
  }

  @override
  Future<void> close() {
    todoFilterSubscription.cancel();
    todoListSubscription.cancel();
    searchTodoSubscription.cancel();
    return super.close();
  }
}
