import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/custom_widgets/custom_dialog_box.dart';
import 'package:task_manager_app/custom_widgets/custom_drop_down_button.dart';
import 'package:task_manager_app/custom_widgets/utils.dart';
import 'package:task_manager_app/view_model/task_list_provider.dart';

import '../view_model/priority_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final newTaskProvider =
        Provider.of<TaskListProvider>(context, listen: true);
    final priorityProvider =
        Provider.of<PriorityProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Task Manager',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
          ),
          centerTitle: true,
          elevation: 3,
          shadowColor: Colors.black,
          backgroundColor: Colors.cyanAccent,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return CustomDialogBox(
                  titleController: titleController,
                  descpController: descpController,
                  heading: 'Add New Task',
                  onPress: () {
                    if (titleController.text.isEmpty ||
                        descpController.text.isEmpty) {
                      Utils.snackBarMessage(context);
                    } else {
                      newTaskProvider.addTask({
                        'Title': titleController.text.toString(),
                        'Description': descpController.text.toString(),
                        'Priority': priorityProvider.dropdownValue.toString(),
                      });
                    }
                    titleController.clear();
                    descpController.clear();
                  },
                  priorityWidget: Row(
                    children: [
                      const Text(
                        'Choose Priority -',
                        style: TextStyle(fontSize: 15),
                      ),
                      CustomDropDownButton(onChanged: (String? newVal) {
                        priorityProvider.setDropDownValue(newVal!);
                      }),
                    ],
                  ),
                );
              },
            );
          },
          backgroundColor: Colors.cyanAccent,
          child: const Icon(Icons.add),
        ),
        body: Consumer<TaskListProvider>(
          builder: (context, value, child) => value.taskList.isEmpty
              ? const Center(
                  child: Text(
                  "No Task Available\nAdd Some Task",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: value.taskList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: (value.taskList[index]['Priority'] == 'High')
                            ? Colors.redAccent.shade700
                            : (value.taskList[index]['Priority'] == 'Medium')
                                ? Colors.yellowAccent
                                : Colors.greenAccent,
                        elevation: 3,
                        child: ListTile(
                          isThreeLine: true,
                          title:
                              Text(value.taskList[index]['Title'].toString()),
                          subtitle: Text(
                              value.taskList[index]['Description'].toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: CustomDropDownButton(
                                          onChanged: (String? newVal) {
                                            priorityProvider
                                                .setDropDownValue(newVal!);
                                            value.taskList[index]['Priority'] =
                                                newVal;
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.priority_high,
                                    color: Colors.black,
                                  )),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomDialogBox(
                                        titleController: titleController,
                                        descpController: descpController,
                                        heading: 'Edit Task',
                                        onPress: () {
                                          if (titleController.text.isEmpty ||
                                              descpController.text.isEmpty) {
                                            Utils.snackBarMessage(context);
                                          } else {
                                            newTaskProvider.updateTask({
                                              'Title': titleController.text
                                                  .toString(),
                                              'Description': descpController
                                                  .text
                                                  .toString(),
                                              'Priority': value.taskList[index]
                                                  ['Priority'],
                                            }, index);
                                            titleController.clear();
                                            descpController.clear();
                                          }
                                        },
                                        priorityWidget: const SizedBox(
                                          width: 5,
                                          height: 5,
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    value.deleteTask(index);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
