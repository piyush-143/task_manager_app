import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  Widget priorityWidget = const SizedBox(
    width: 1,
    height: 0,
  );
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
    return AlertDialog(
      title: Text(
        widget.heading,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      content: SizedBox(
        width: 350,
        height: 230,
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
