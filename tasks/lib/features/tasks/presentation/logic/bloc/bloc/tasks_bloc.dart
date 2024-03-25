import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tasks/features/tasks/domain/entities/task.dart';
import 'package:tasks/features/tasks/domain/repo/tasks_repo.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

@Injectable()
class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc(this.tasksRepository) : super(TasksInitial()) {
    on<GetTasks>(_onGetTasks);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<CreateTask>(_onCreateTask);
  }
  final TasksRepository tasksRepository;
  FutureOr<void> _onGetTasks(GetTasks event, Emitter<TasksState> emit) async {
    emit(TasksLoading());

    final tasks = await tasksRepository.getTasks();
    tasks.fold(
      (l) => emit(TasksError(
        l.message,
      )),
      (r) => emit(
        TasksLoaded(r),
      ),
    );
  }

  FutureOr<void> _onUpdateTask(
      UpdateTask event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    final tasks =
        await tasksRepository.updateTask(event.updatedTask, event.taskList);
    tasks.fold(
      (l) => emit(TasksError(
        l.message,
      )),
      (r) => emit(
        UpdatedTask(r),
      ),
    );
  }

  FutureOr<void> _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    final tasks = await tasksRepository.deleteTask(event.task, event.taskList);
    tasks.fold(
      (l) => emit(TasksError(
        l.message,
      )),
      (r) => emit(
        DeletedTask(r),
      ),
    );
  }

  FutureOr<void> _onCreateTask(CreateTask event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    final tasks = await tasksRepository.createTask(event.task, event.taskList);
    tasks.fold(
      (l) => emit(TasksError(
        l.message,
      )),
      (r) => emit(
        CreatedTask(r),
      ),
    );
  }
}
