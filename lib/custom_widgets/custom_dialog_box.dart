import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/custom_widgets/custom_drop_down_button.dart';
import 'package:task_manager_app/view_model/priority_provider.dart';
import 'package:task_manager_app/view_model/task_list_provider.dart';

class CustomDialogBox extends StatefulWidget {
  Widget priorityWidget = Row();
  final titleController, descpController;
  String heading;
  VoidCallback onPress;
  CustomDialogBox({
    super.key,
    required this.onPress,
    required this.titleController,
    required this.descpController,
    required this.priorityWidget,
    required this.heading,
  });

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    final newTaskProvider =
        Provider.of<TaskListProvider>(context, listen: false);

    return AlertDialog(
      title: Text(
        widget.heading,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      content: Container(
        width: 350,
        height: 220,
        child: Column(
          children: [
            TextFormField(
              controller: widget.titleController,
              decoration: const InputDecoration(labelText: 'Enter Task'),
            ),
            TextFormField(
              controller: widget.descpController,
              decoration: const InputDecoration(labelText: 'Enter Description'),
            ),
            widget.priorityWidget,
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: widget.onPress,
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.cyanAccent)),
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
