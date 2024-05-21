import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:novoy/global/global.dart';
import 'package:novoy/model/trip/trip_model.dart';
import 'package:novoy/resources/responsive.dart';
import 'package:novoy/shared/component/k_text.dart';

import '../../model/todo_list/todo_list_model.dart';
import 'widgets/todo_card.dart';

class TodoListScreen extends StatefulWidget {
  final TripModel trip;
  const TodoListScreen({
    super.key,
    required this.trip,
  });

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final _fb = FirebaseFirestore.instance;
  late TripModel trip = widget.trip;
  List<TodoListModel> todoList = [];
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (trip.todoList != null) {
      todoList = trip.todoList!;
      // sort todo list by created date in last to first order
      todoList.sort((a, b) => b.createdDate!.compareTo(a.createdDate!));
      // sort todo list by isCompleted in last to first order
      for (var i = 0; i < todoList.length; i++) {
        if (todoList[i].isCompleted!) {
          todoList.insert(0, todoList.removeAt(i));
        }
      }
    }
  }

  Future<void> updateTodoList() async {
    setState(() {
      isLoading = true;
      context.loaderOverlay.show();
    });
    // update todo list
    trip = trip.copyWith(
      todoList: todoList,
    );
    // update trip
    try {
      await _fb.collection('trips').doc(trip.tripId).update(
            trip.toJson(),
          );
    } catch (e) {
      log('Error updating todo list: $e');
    } finally {
      setState(() {
        isLoading = false;
        context.loaderOverlay.hide();
      });
    }
    // update trip
    Global.kTrips = List.from(Global.kTrips)
      ..removeWhere((element) => element.tripId == trip.tripId);

    Global.kTrips = List.from(Global.kTrips)..add(trip);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            onPressed: () {
              // Add new todo
              // show model bottom sheet
              showBarModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  height: responsive.sHeight(context) * 0.5,
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kText(
                              text: 'Add new todo',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            responsive.sizedBoxH10,
                            TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                hintText: 'Enter todo',
                              ),
                              onSubmitted: (value) {
                                //
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  todoList.add(
                                    TodoListModel(
                                      id: DateTime.now().toString(),
                                      title: _controller.text, // title
                                      author: kUser,
                                      createdDate: DateTime.now(),
                                      updatedDate: null,
                                      isCompleted: false,
                                      assignees: [],
                                    ),
                                  );
                                });
                                _controller.clear();
                                updateTodoList();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Add'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: todoList.isEmpty
          ? const Center(
              child: Text('No todo list found'),
            )
          : ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                TodoListModel todo = todoList[index];

                return Dismissible(
                  key: ValueKey(todo.id),
                  confirmDismiss: (direction) async {
                    return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Todo'),
                        content: const Text(
                          'Are you sure you want to delete this todo?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                todoList = List.from(todoList)
                                  ..removeWhere(
                                    (element) => element.id == todo.id,
                                  );
                                updateTodoList();
                              });
                              Navigator.of(context).pop(true);
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    );
                  },
                  secondaryBackground: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  background: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                            ),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: TodoListCard(
                    key: ValueKey(todo.id),
                    todo: todo,
                    onTodoCompleted: (vale) {
                      setState(() {
                        // update unmodifiable list
                        todoList = List.from(todoList)
                          ..removeWhere((element) => element.id == vale.id);

                        // update todo

                        if ((vale.assignees != null &&
                                trip.groupMembers != null) &&
                            vale.assignees!.length ==
                                (trip.groupMembers!.length + 1)) {
                          // update trip status
                          vale = vale.copyWith(
                            isCompleted: true,
                          );
                          // update trip
                        } else if ((trip.groupMembers == null ||
                                trip.groupMembers!.isEmpty) &&
                            vale.assignees!.isNotEmpty) {
                          vale = vale.copyWith(
                            isCompleted: true,
                          );
                        } else {
                          vale = vale.copyWith(
                            isCompleted: false,
                          );
                        }

                        log(" Hello ${trip.groupMembers!.length} ${vale.assignees!.length}");
                        todoList = List.from(todoList)..add(vale);
                        log('Todo completed: ${todo.assignees}');
                        // length of assignees
                        log('todoList todoList: ${todoList.length}');
                        setState(() {
                          todoList = todoList;
                        });
                        updateTodoList();
                        log('Todo completed: ${todo.assignees}');
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
