
import 'package:tasks/features/tasks/domain/entities/task.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

class EditParameters {
  EditParameters({required this.task, required this.tasks});
  final TaskDTO task;
  final List<TaskDTO> tasks;
}