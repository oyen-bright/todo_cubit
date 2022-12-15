import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_cubit/model/todo_model.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListState.initial());

  void addTask({required String desc}) {
    final newTodo = [...state.todos, Todo(desc: desc)];
    emit(state.copyWith(todos: newTodo));
    print(state);
  }

  void editTodo({required String id, required String desc}) {
    final todos = state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(id: id, desc: desc, completed: todo.completed);
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: todos));
  }

  void togolleTodo({required String id}) {
    final todos = state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(id: id, desc: todo.desc, completed: !todo.completed);
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: todos));
  }

  void removeTodo(Todo todo) {
    final todos = state.todos.where((Todo t) => t.id != todo.id).toList();
    emit(state.copyWith(todos: todos));
  }
}
