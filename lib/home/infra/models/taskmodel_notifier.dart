import 'package:flutter/material.dart';

class TaskModel extends ChangeNotifier {
  final List<String> _tasks = [];

  List<String> get tasks => List.unmodifiable(_tasks);

  void addTask(String task) {
    _tasks.add(task);
    notifyListeners(); 
  }
}
