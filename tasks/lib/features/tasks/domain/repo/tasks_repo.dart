import 'package:injectable/injectable.dart';
import 'package:tasks/core/networking/network_client.dart';
import 'package:tasks/features/tasks/domain/entities/task.dart';

abstract class TasksRepository {
  Future<DT<List<TaskDTO>>>  getTasks();
  Future<DT<List<TaskDTO>>> updateTask(TaskDTO updatedTask, List<TaskDTO> taskList);
  Future<DT<List<TaskDTO>>> createTask(TaskDTO task, List<TaskDTO> taskList);
  Future<DT<List<TaskDTO>>> deleteTask(TaskDTO task, List<TaskDTO> taskList);
}