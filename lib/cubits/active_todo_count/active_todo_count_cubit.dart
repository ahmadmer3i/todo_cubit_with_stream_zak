import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_cubit_with_stream/cubits/todo_list/todo_list_cubit.dart';

import '../../models/todo_model.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  late final StreamSubscription todoListSubscription;
  final TodoListCubit todoListCubit;
  final int initialCount;
  ActiveTodoCountCubit(
      {required this.initialCount, required this.todoListCubit})
      : super(ActiveTodoCountState(activeTodoCount: initialCount)) {
    todoListSubscription = todoListCubit.stream.listen(
      (TodoListState todoListState) {
        emit(state.copyWith(
            activeTodoCount: todoListState.todos
                .where((Todo todo) => !todo.isCompleted)
                .toList()
                .length));
      },
    );
  }
  @override
  Future<void> close() {
    todoListSubscription.cancel();
    return super.close();
  }
}
