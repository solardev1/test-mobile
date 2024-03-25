part of 'tasks_bloc.dart';

sealed class TasksState extends Equatable {
  const TasksState();
  
  @override
  List<Object> get props => [];
}

final class TasksInitial extends TasksState {}

final class TasksLoading extends TasksState {}

final class TasksLoaded extends TasksState {
  final List<TaskDTO> tasks;

  const TasksLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}

final class TasksError extends TasksState {
  final String message;

  const TasksError(this.message);

  @override
  List<Object> get props => [message];
}
