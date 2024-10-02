import 'package:flutter/material.dart';

class TaskListProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _taskList = [];
  List<Map<String, dynamic>> get taskList => _taskList;

  void addTask(Map<String, dynamic> data) {
    _taskList.add(data);
    notifyListeners();
  }

  void updateTask(Map<String, dynamic> updatedData, int idx) {
    _taskList[idx] = updatedData;
    notifyListeners();
  }

  void deleteTask(int idx) {
    _taskList.removeAt(idx);
    notifyListeners();
  }
}
