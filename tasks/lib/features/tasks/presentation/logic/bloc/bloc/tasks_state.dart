part of 'tasks_bloc.dart';

sealed class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

final class TasksInitial extends TasksState {}

final class TasksLoading extends TasksState {}

final class TasksLoaded extends TasksState {
  const TasksLoaded(this.tasks);
  final List<TaskDTO> tasks;

  @override
  List<Object> get props => [tasks];
}

final class UpdatedTask extends TasksState {
  const UpdatedTask(this.tasks);
  final List<TaskDTO> tasks;

  @override
  List<Object> get props => [tasks];
}

final class DeletedTask extends TasksState {
  const DeletedTask(this.tasks);
  final List<TaskDTO> tasks;

  @override
  List<Object> get props => [tasks];
}
final class CreatedTask extends TasksState {
  const CreatedTask(this.tasks);
  final List<TaskDTO> tasks;

  @override
  List<Object> get props => [tasks];
}
final class TasksError extends TasksState {
  const TasksError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
