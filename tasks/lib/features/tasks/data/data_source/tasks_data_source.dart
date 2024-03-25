import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasks/core/mocks/tasks/tasks_list.dart';
import 'package:tasks/core/networking/network_client.dart';
import 'package:tasks/features/tasks/data/mappers/tasks_response.dart';

abstract class TasksDataSource {
   Future<DT<TasksResponse>> getTasks();
    Future<DT<List<TaskResponse>>> updateTask(TaskResponse updatedTask, List<TaskResponse> taskList);
}

@Environment('DEV')
@Environment('MOCK')
@Singleton(as: TasksDataSource)
class TasksDataSourceImpl implements TasksDataSource {
final NetworkClient networkClient;

TasksDataSourceImpl({required this.networkClient});

  @override
  Future<DT<TasksResponse>> getTasks() async {
    await Future.delayed(const Duration(seconds: 2));
return right(TasksResponse.fromJson(tasksResponseMock));
  }
  
  @override
  Future<DT<List<TaskResponse>>> updateTask(TaskResponse updatedTask, List<TaskResponse> taskList) async{
  // Buscar el índice del elemento a actualizar
  int index = taskList.indexWhere((task) => task.id == updatedTask.id);

  // Si se encontró el elemento
  if (index != -1) {
    // Actualizar el elemento en la lista
    taskList[index] = updatedTask;
  }

  // Devolver la lista actualizada
  return right(taskList);
}

}