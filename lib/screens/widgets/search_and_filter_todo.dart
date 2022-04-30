import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_with_stream/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo_cubit_with_stream/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo_cubit_with_stream/models/todo_model.dart';

class SearchAndFilter extends StatelessWidget {
  const SearchAndFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoSearchTextField(
          onChanged: (String? searchText) {
            if (searchText != null) {
              context
                  .read<TodoSearchCubit>()
                  .setSearchText(searchText: searchText);
            }
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButton(context, filter: Filter.all),
            filterButton(context, filter: Filter.active),
            filterButton(context, filter: Filter.completed),
          ],
        )
      ],
    );
  }

  Widget filterButton(BuildContext context, {required Filter filter}) {
    return TextButton(
      onPressed: () {
        context.read<TodoFilterCubit>().setTodoFilter(filter: filter);
      },
      child: Text(
        filter == Filter.all
            ? 'All'
            : filter == Filter.active
                ? 'Active'
                : 'Completed',
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
