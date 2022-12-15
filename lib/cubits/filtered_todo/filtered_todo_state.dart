// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filtered_todo_cubit.dart';

class FilteredTodoState extends Equatable {
  final List<Todo> fillteredTodos;
  const FilteredTodoState({
    required this.fillteredTodos,
  });

  @override
  List<Object?> get props => [fillteredTodos];

  FilteredTodoState copyWith({
    List<Todo>? fillteredTodos,
  }) {
    return FilteredTodoState(
      fillteredTodos: fillteredTodos ?? this.fillteredTodos,
    );
  }

  factory FilteredTodoState.initial() {
    return const FilteredTodoState(fillteredTodos: []);
  }

  @override
  bool get stringify => true;
}
