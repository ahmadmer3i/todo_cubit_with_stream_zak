part of 'todo_search_cubit.dart';

class TodoSearchState extends Equatable {
  final String searchText;

  const TodoSearchState({
    required this.searchText,
  });

  factory TodoSearchState.initial() {
    return const TodoSearchState(searchText: '');
  }

  @override
  List<Object> get props => [searchText];

  TodoSearchState copyWith({
    String? searchText,
  }) {
    return TodoSearchState(
      searchText: searchText ?? this.searchText,
    );
  }

  @override
  String toString() {
    return 'TodoSearchState{searchText: $searchText}';
  }
}
