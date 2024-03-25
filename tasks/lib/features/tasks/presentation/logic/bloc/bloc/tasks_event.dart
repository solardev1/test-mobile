part of 'tasks_bloc.dart';

sealed class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class GetTasks extends TasksEvent {
  const GetTasks();

  @override
  List<Object> get props => [];
}

class UpdateTask extends TasksEvent {

  const UpdateTask(this.updatedTask, this.taskList);
  final TaskDTO updatedTask;
  final List<TaskDTO> taskList;

  @override
  List<Object> get props => [updatedTask, taskList];
}

class DeleteTask extends TasksEvent {

  const DeleteTask(this.task, this.taskList);
  final TaskDTO task;
  final List<TaskDTO> taskList;

  @override
  List<Object> get props => [task, taskList];
}

class CreateTask extends TasksEvent {

  const CreateTask(this.task, this.taskList);
  final TaskDTO task;
  final List<TaskDTO> taskList;

  @override
  List<Object> get props => [task, taskList];
}
