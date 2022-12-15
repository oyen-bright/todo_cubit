import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/cubits/cubits.dart';
import 'package:todo_cubit/model/todo_model.dart';
import 'package:todo_cubit/utils/debounce.dart';

class SearchAdnFilter extends StatelessWidget {
  SearchAdnFilter({super.key});
  final debounce = Debounce(millilsecond: 1000000);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
              labelText: "Search Todo",
              border: InputBorder.none,
              filled: true,
              prefixIcon: Icon(Icons.search)),
          onChanged: (String? value) {
            if (value != null && value.trim().isNotEmpty) {
              debounce.run(() {
                context.read<TodoSearchCubit>().setSearchTerm(value);
              });
            } else {
              context.read<TodoSearchCubit>().setSearchTerm("");
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterButton(context, Filter.all),
            FilterButton(context, Filter.active),
            FilterButton(context, Filter.completed),
          ],
        )
      ],
    );
  }
}

// ignore: non_constant_identifier_names
Widget FilterButton(BuildContext context, Filter filter) {
  return TextButton(
      onPressed: () {
        context.read<TodoFilterCubit>().changeFiler(filter);
      },
      child: Text(
          filter == Filter.active
              ? "Active"
              : filter == Filter.all
                  ? "All"
                  : "Completed",
          style: TextStyle(fontSize: 18, color: textColor(context, filter))));
}

Color textColor(BuildContext context, Filter filter) {
  final currentFilter = context.watch<TodoFilterCubit>().state.filter;
  return currentFilter == filter ? Colors.blue : Colors.grey;
}
