import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/custom_widgets/custom_dialog_box.dart';
import 'package:task_manager_app/view_model/task_list_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descpController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newTaskProvider =
        Provider.of<TaskListProvider>(context, listen: true);
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
                  onPress: () {
                    newTaskProvider.addTask({
                      'Title': titleController.toString(),
                      'Description': descpController.toString(),
                    });
                  },
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
                child: ListTile(
                  title: Text(value.taskList[index]['Title'].toString()),
                  subtitle:
                      Text(value.taskList[index]['Description'].toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            CustomDialogBox(
                              titleController: titleController,
                              descpController: descpController,
                              onPress: () {
                                newTaskProvider.updateTask({
                                  'Title': titleController.toString(),
                                  'Description': descpController.toString(),
                                }, index);
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          )),
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
    );
  }
}
