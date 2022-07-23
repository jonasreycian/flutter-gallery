import 'dart:convert';

import 'package:get/get.dart';

import '../../../core/utils/keys.dart';
import '../../models/task.dart';
import '../../services/storage/service.dart';

class TaskProvider {
  final StorageService _storageService = Get.find<StorageService>();

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storageService.read(taskKey.toString())).forEach((task) {
      tasks.add(Task.fromJson(task));
    });
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    _storageService.write(taskKey, jsonEncode(tasks));
  }
}
