// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_cubit/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo_cubit/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_cubit/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo_cubit/model/todo_model.dart';

part 'filtered_todo_state.dart';

class FilteredTodoCubit extends Cubit<FilteredTodoState> {
  final TodoSearchCubit todoSearchCubit;
  final TodoFilterCubit todoFilterCubit;
  final TodoListCubit todoListCubit;

  final List<Todo> intialTodos;

  late final StreamSubscription todoSearchCubitStreamSubscription;
  late final StreamSubscription todoFilterCubitStreamSubscription;
  late final StreamSubscription todoListCubitStreamSubscription;

  FilteredTodoCubit({
    required this.intialTodos,
    required this.todoSearchCubit,
    required this.todoFilterCubit,
    required this.todoListCubit,
  }) : super(FilteredTodoState(fillteredTodos: intialTodos)) {
    todoFilterCubitStreamSubscription =
        todoFilterCubit.stream.listen((TodoFilterState todoFilterState) {
      setFillteredTodo();
    });
    todoSearchCubitStreamSubscription =
        todoSearchCubit.stream.listen((TodoSearchState todoFilterState) {
      setFillteredTodo();
    });
    todoListCubitStreamSubscription =
        todoListCubit.stream.listen((TodoListState todoFilterState) {
      setFillteredTodo();
    });
  }

  void setFillteredTodo() {
    List<Todo> fillteredTodo = [];

    switch (todoFilterCubit.state.filter) {
      case Filter.active:
        fillteredTodo =
            todoListCubit.state.todos.where((Todo t) => !t.completed).toList();
        break;
      case Filter.completed:
        fillteredTodo =
            todoListCubit.state.todos.where((Todo t) => t.completed).toList();
        break;
      case Filter.all:
      default:
        fillteredTodo = todoListCubit.state.todos;
        break;
    }
    print(todoSearchCubit.state.searchTerm);
    print(todoSearchCubit.state.searchTerm.isNotEmpty);

    if (todoSearchCubit.state.searchTerm.isNotEmpty) {
      fillteredTodo = todoListCubit.state.todos
          .where((Todo t) => t.desc
              .toLowerCase()
              .contains(todoSearchCubit.state.searchTerm.toLowerCase()))
          .toList();
    }

    emit(state.copyWith(fillteredTodos: fillteredTodo));
  }

  @override
  Future<void> close() {
    todoSearchCubitStreamSubscription.cancel();
    todoFilterCubitStreamSubscription.cancel();
    todoListCubitStreamSubscription.cancel();
    return super.close();
  }
}
