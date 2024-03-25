import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tasks/core/networking/network_client.dart';
import 'package:tasks/features/tasks/data/data_source/tasks_data_source.dart';
import 'package:tasks/features/tasks/data/mappers/tasks_response.dart';
import 'package:tasks/features/tasks/domain/entities/task.dart';
import 'package:tasks/features/tasks/domain/repo/tasks_repo.dart';

@Singleton(as: TasksRepository)
class TaskRespositoryimpl implements TasksRepository {
  TaskRespositoryimpl({required this.dataSource});

  final TasksDataSource dataSource;

  @override
  Future<DT<List<TaskDTO>>> getTasks() async {
    final response = await dataSource.getTasks();

    return response.fold(
      left,
      (r) => right(
        r.tasks
            .map(
              (task) => TaskDTO(
                id: task.id,
                title: task.title,
                description: task.description,
                priority: task.priority,
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Future<DT<List<TaskDTO>>> updateTask(
      TaskDTO updatedTask, List<TaskDTO> taskList) async {
    final tasksResquest = TaskResponse(
      id: updatedTask.id,
      title: updatedTask.title,
      description: updatedTask.description,
      priority: updatedTask.priority,
    );

    final listRequest = taskList
        .map((task) => TaskResponse(
              id: task.id,
              title: task.title,
              description: task.description,
              priority: task.priority,
            ))
        .toList();

    final response = await dataSource.updateTask(tasksResquest, listRequest);
    return response.fold(
      left,
      (r) => right(
        r
            .map(
              (task) => TaskDTO(
                id: task.id,
                title: task.title,
                description: task.description,
                priority: task.priority,
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Future<DT<List<TaskDTO>>> deleteTask(
      TaskDTO task, List<TaskDTO> taskList) async {
    final taskRequest = TaskResponse(
      id: task.id,
      title: task.title,
      description: task.description,
      priority: task.priority,
    );

    final listRequest = taskList
        .map((task) => TaskResponse(
              id: task.id,
              title: task.title,
              description: task.description,
              priority: task.priority,
            ))
        .toList();

    final response = await dataSource.deleteTask(taskRequest, listRequest);
    return response.fold(
      left,
      (r) => right(
        r
            .map(
              (task) => TaskDTO(
                id: task.id,
                title: task.title,
                description: task.description,
                priority: task.priority,
              ),
            )
            .toList(),
      ),
    );
  }
  
  @override
  Future<DT<List<TaskDTO>>> createTask(TaskDTO task, List<TaskDTO> taskList) {
    final taskRequest = TaskResponse(
      id: task.id,
      title: task.title,
      description: task.description,
      priority: task.priority,
    );
    final listRequest = taskList
        .map((task) => TaskResponse(
              id: task.id,
              title: task.title,
              description: task.description,
              priority: task.priority,
            ))
        .toList();
    return dataSource.createTask(taskRequest, listRequest).then((response) {
      return response.fold(
        left,
        (r) => right(
          r
              .map(
                (task) => TaskDTO(
                  id: task.id,
                  title: task.title,
                  description: task.description,
                  priority: task.priority,
                ),
              )
              .toList(),
        ),
      );
    });
  }
}
