import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasks/core/mocks/tasks/tasks_list.dart';
import 'package:tasks/core/networking/network_client.dart';
import 'package:tasks/features/tasks/data/mappers/tasks_response.dart';

abstract class TasksDataSource {
  Future<DT<TasksResponse>> getTasks();
  Future<DT<List<TaskResponse>>> updateTask(
      TaskResponse updatedTask, List<TaskResponse> taskList);
  Future<DT<List<TaskResponse>>> createTask(
      TaskResponse task, List<TaskResponse> taskList);
  Future<DT<List<TaskResponse>>> deleteTask(
      TaskResponse task, List<TaskResponse> taskList);
}

@Environment('DEV')
@Environment('MOCK')
@Singleton(as: TasksDataSource)
class TasksDataSourceImpl implements TasksDataSource {
  final NetworkClient networkClient;

  TasksDataSourceImpl({required this.networkClient});

  @override
  Future<DT<TasksResponse>> getTasks() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return right(TasksResponse.fromJson(tasksResponseMock));
  }

  @override
  Future<DT<List<TaskResponse>>> updateTask(
      TaskResponse updatedTask, List<TaskResponse> taskList) async {
    int index = taskList.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      taskList[index] = updatedTask;
    }
    return right(taskList);
  }

  @override
  Future<DT<List<TaskResponse>>> deleteTask(
      TaskResponse task, List<TaskResponse> taskList) async {
    taskList.removeWhere((element) => element.id == task.id);
    return right(taskList);
  }

  @override
  Future<DT<List<TaskResponse>>> createTask(
      TaskResponse task, List<TaskResponse> taskList) async {
    taskList.add(task);
    return right(taskList);
  }
}
