// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo_cubit/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_cubit/model/todo_model.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  TodoListCubit todoListCubit;

  final int initialActiveTodoCount;

  late final StreamSubscription todoListCubitStreamSubscrption;
  ActiveTodoCountCubit({
    required this.initialActiveTodoCount,
    required this.todoListCubit,
  }) : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {
    todoListCubitStreamSubscrption =
        todoListCubit.stream.listen((TodoListState todoListState) {
      final int count =
          todoListState.todos.where((Todo t) => !t.completed).toList().length;
      emit(state.copyWith(activeTodoCount: count));
    });
  }

  @override
  Future<void> close() {
    todoListCubitStreamSubscrption.cancel();
    return super.close();
  }
}
