import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/cubits/active_todo_count/active_todo_count_cubit.dart';
import 'package:todo_cubit/cubits/filtered_todo/filtered_todo_cubit.dart';
import 'package:todo_cubit/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo_cubit/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_cubit/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo_cubit/pages/todopage.dart';

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
        BlocProvider<TodoFilterCubit>(
          create: (BuildContext context) => TodoFilterCubit(),
        ),
        BlocProvider<TodoSearchCubit>(
          create: (BuildContext context) => TodoSearchCubit(),
        ),
        BlocProvider<TodoListCubit>(
          lazy: false,
          create: (BuildContext context) => TodoListCubit(),
        ),
        BlocProvider<ActiveTodoCountCubit>(
          create: (BuildContext context) => ActiveTodoCountCubit(
              initialActiveTodoCount:
                  context.read<TodoListCubit>().state.todos.length,
              todoListCubit: context.read<TodoListCubit>()),
        ),
        BlocProvider<FilteredTodoCubit>(
          create: (BuildContext context) => FilteredTodoCubit(
              intialTodos: context.read<TodoListCubit>().state.todos,
              todoFilterCubit: context.read<TodoFilterCubit>(),
              todoListCubit: context.read<TodoListCubit>(),
              todoSearchCubit: context.read<TodoSearchCubit>()),
        ),
      ],
      child: MaterialApp(
        title: 'Todo',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        home: const TodoPage(),
      ),
    );
  }
}
