import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/core/widgets/custom_app_bard.dart';
import 'package:tasks/features/tasks/domain/entities/task.dart';
import 'package:tasks/features/tasks/presentation/logic/bloc/bloc/tasks_bloc.dart';
import 'package:tasks/features/tasks/presentation/widgets/tasks_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.tasks});
  final List<TaskDTO>? tasks;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print('tasks: ${widget.tasks}');
    if (widget.tasks == null || widget.tasks!.isEmpty) {
      context.read<TasksBloc>().add(const GetTasks());
    }

    return Scaffold(
      appBar: CustomAppbar(),
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if (state is TasksLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TasksError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is TasksLoaded) {
            return TaskListScreen(
              tasks: state.tasks,
            );
          }
          if (widget.tasks != null && widget.tasks!.isNotEmpty) {
            return TaskListScreen(
              tasks: widget.tasks!,
            );
          } else {
            return const Center(
              child: Text('No hay tareas'),
            );
          }
        },
      ),
    );
  }
}
