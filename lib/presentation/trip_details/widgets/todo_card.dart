import 'package:flutter/material.dart';
import 'package:novoy/model/todo_list/todo_list_model.dart';

import '../../../global/global.dart';
import '../../../model/user/user_model.dart';
import '../../../shared/component/k_text.dart';

class TodoListCard extends StatefulWidget {
  final TodoListModel todo;
  final Function(TodoListModel todo) onTodoCompleted;
  const TodoListCard({
    super.key,
    required this.todo,
    required this.onTodoCompleted,
  });

  @override
  State<TodoListCard> createState() => _TodoListCardState();
}

class _TodoListCardState extends State<TodoListCard> {
  late TodoListModel todo = widget.todo;
  late Function(TodoListModel todo) onTodoCompleted = widget.onTodoCompleted;
  bool selected = false;

  @override
  void didUpdateWidget(TodoListCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    todo = widget.todo;
    onTodoCompleted = widget.onTodoCompleted;
  }

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < todo.assignees!.length; i++) {
      if (todo.assignees![i].uId == kUser!.uId) {
        setState(() {
          selected = true;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: kText(
        text: todo.title!,
        fontSize: 18,
        color: todo.isCompleted! ? Colors.grey : Colors.black,
        fontWeight: todo.isCompleted! ? FontWeight.w400 : FontWeight.w600,
      ),
      subtitle: todo.assignees!.isNotEmpty
          ? Row(
              children: [
                // circle avatars of assignees of image url if available else initials
                ...todo.assignees!.map((e) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundImage:
                            e.imageUrl != null && e.imageUrl!.isNotEmpty
                                ? NetworkImage(e.imageUrl!)
                                : null,
                        child: e.imageUrl == null
                            ? Text(
                                e.name![0],
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 5),
                      // name of assignee first name only
                      kText(
                        text: e.name!.split(' ')[0],
                        fontSize: 10,
                      ),
                    ],
                  );
                }).toList(),
              ],
            )
          : null,
      trailing: Checkbox(
        value: selected,
        onChanged: (value) {
          setState(() {
            selected = value!;
          });
          if (value == true) {
            // add current user to assignees
            List<UserModel> assigners = todo.assignees ?? [];
            assigners = List.from(assigners)..add(kUser!);
            todo = todo.copyWith(
              assignees: assigners,
            );
            onTodoCompleted(todo);
          } else {
            // remove current user from assignees
            List<UserModel> assigners = todo.assignees ?? [];
            // for (var i = 0; i < assigners.length; i++) {
            //   if (assigners[i].uId == kUser!.uId) {
            //     assigners.removeAt(i);
            //     break;
            //   }
            // }
            assigners = assigners
                .where((element) => element.uId != kUser!.uId)
                .toList();

            setState(() {
              todo = todo.copyWith(
                assignees: assigners,
              );
            });
            onTodoCompleted(todo);
          }
        },
      ),
    );
  }
}
