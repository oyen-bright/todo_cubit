import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/cubits/cubits.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTodoCubit, FilteredTodoState>(
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemCount: state.fillteredTodos.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: Colors.grey,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return TodoWidget(
              state: state,
              index: index,
            );
          },
        );
      },
    );
  }
}

class TodoWidget extends StatefulWidget {
  final FilteredTodoState state;
  final int index;
  const TodoWidget({
    required this.state,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  late final TextEditingController textcontroller;

  @override
  void initState() {
    textcontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (DismissDirection dismissDirection) {
        return showDialog(
            context: context,
            builder: ((context) {
              return CupertinoAlertDialog(
                title: const Text("Are you sure ?"),
                content: const Text("Do you really want to delete ?"),
                actions: [
                  CupertinoButton(
                      onPressed: (() => Navigator.pop(context, false)),
                      child: const Text("NO")),
                  CupertinoButton(
                      onPressed: (() => Navigator.pop(context, true)),
                      child: const Text("YES"))
                ],
              );
            }));
      },
      background: showBackground(0),
      secondaryBackground: showBackground(1),
      key: ValueKey(widget.state.fillteredTodos[widget.index].id),
      onDismissed: (DismissDirection dismissDirextion) {
        context
            .read<TodoListCubit>()
            .removeTodo(widget.state.fillteredTodos[widget.index]);
      },
      child: GestureDetector(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (_) {
                textcontroller.text =
                    widget.state.fillteredTodos[widget.index].desc;
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return CupertinoAlertDialog(
                    title: const Text("Edit Todo"),
                    content: CupertinoTextField(
                      autofocus: true,
                      controller: textcontroller,
                    ),
                    actions: [
                      CupertinoButton(
                          onPressed: (() => Navigator.pop(context, false)),
                          child: const Text("Cacel")),
                      CupertinoButton(
                          onPressed: (() {
                            context.read<TodoListCubit>().editTodo(
                                id: widget
                                    .state.fillteredTodos[widget.index].id,
                                desc: textcontroller.text);
                            Navigator.pop(context);
                          }),
                          child: const Text("Confirm"))
                    ],
                  );
                });
              });
        },
        child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: widget.state.fillteredTodos[widget.index].completed,
          onChanged: (bool? newValue) {
            context
                .read<TodoListCubit>()
                .togolleTodo(id: widget.state.fillteredTodos[widget.index].id);
          },
          title: Text(widget.state.fillteredTodos[widget.index].desc),
        ),
      ),
    );
  }
}

Widget showBackground(int direction) {
  return Container(
    color: direction == 0 ? Colors.grey : Colors.red,
    alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    child: Icon(
      direction == 0 ? Icons.edit : Icons.delete,
      color: Colors.white,
    ),
  );
}
