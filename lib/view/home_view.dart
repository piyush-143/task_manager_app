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
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   titleController.dispose();
  //   descpController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final newTaskProvider =
        Provider.of<TaskListProvider>(context, listen: true);
    final priorityProvider =
        Provider.of<PriorityProvider>(context, listen: false);
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
          builder: (context, value, child) => ListView.builder(
            itemCount: value.taskList.length,
            itemBuilder: (context, index) {
              return Card(
                color: (value.taskList[index]['Priority'] == 'High')
                    ? Colors.redAccent
                    : (value.taskList[index]['Priority'] == 'Medium')
                        ? Colors.yellowAccent
                        : Colors.greenAccent,
                child: ListTile(
                  title: Text(value.taskList[index]['Title'].toString()),
                  subtitle:
                      Text(value.taskList[index]['Description'].toString()),
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
                                    value.taskList[index]['Priority'] = newVal;
                                    priorityProvider.setDropDownValue(newVal!);
                                  },
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.priority_high)),
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
                                    newTaskProvider.updateTask({
                                      'Title': titleController.text.toString(),
                                      'Description':
                                          descpController.text.toString(),
                                    }, index);
                                    titleController.clear();
                                    descpController.clear();
                                  },
                                  priorityWidget: const Row(),
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          )),
                      IconButton(
                          onPressed: () {
                            value.deleteTask(index.toInt());
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
    );
  }
}
