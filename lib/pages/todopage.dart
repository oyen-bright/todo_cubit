import 'package:flutter/material.dart';
import 'package:todo_cubit/pages/createtod.dart';
import 'package:todo_cubit/pages/search_and_filter.dart';
import 'package:todo_cubit/pages/showtodos.dart';
import 'package:todo_cubit/pages/todoheader.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                const TodoHeader(),
                const CreateTodo(),
                const SizedBox(
                  height: 20,
                ),
                SearchAdnFilter(),
                const ShowTodos()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
