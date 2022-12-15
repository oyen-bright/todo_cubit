import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/cubits/cubits.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final TextEditingController todoTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    todoTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: todoTextEditingController,
      decoration: const InputDecoration(labelText: "What to do ?"),
      onSubmitted: ((String? value) {
        if (value != null && value.trim().isNotEmpty) {
          context.read<TodoListCubit>().addTask(desc: value);
          todoTextEditingController.clear();
        }
      }),
    );
  }
}
