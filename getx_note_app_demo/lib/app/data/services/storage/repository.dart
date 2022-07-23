import '../../models/task.dart';
import '../../providers/task/provider.dart';

class TaskRepository {
  final TaskProvider taskProvider;

  TaskRepository({required this.taskProvider});

  List<Task> readTasks() {
    return taskProvider.readTasks();
  }

  void writeTasks(List<Task> tasks) {
    taskProvider.writeTasks(tasks);
  }
}
