import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum Filter {
  all,
  completed,
  active,
}

Uuid uuid = const Uuid();

class Todo extends Equatable {
  final String title;
  final String id;
  final bool isCompleted;

  Todo({
    required this.title,
    String? id,
    this.isCompleted = false,
  }) : id = id ?? uuid.v1();

  @override
  List<Object> get props => [title, id, isCompleted];

  @override
  String toString() {
    return 'Todo{title: $title, id: $id, isCompleted: $isCompleted}';
  }
}
