import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks/core/routes/list_routers.dart';
import 'package:tasks/core/theme/app_colors.dart';
import 'package:tasks/core/widgets/custom_app_bard.dart';
import 'package:tasks/features/tasks/domain/entities/task.dart';
import 'package:tasks/features/tasks/presentation/logic/bloc/bloc/tasks_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    context.read<TasksBloc>().add(const GetTasks());
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
          }
          else if (state is TasksLoaded) {
            return TaskListScreen(
              tasks: state.tasks,
            );
          } else {
            return const Center(
              child: Text('No hay tareas'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary.withOpacity(0.7),
        onPressed: () {
          context.pushNamed(AppRoute.editTask.name);
        },
        child: const Icon(
          Icons.add,
          color: AppColors.low,
        ),
      ),
    );
  }
}

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key, required this.tasks});

  final List<TaskDTO> tasks;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLigthBackground,
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Card(
              child: ListTile(
                title: Text(tasks[index].title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Descripción: ${tasks[index].description}'),
                    Text('Prioridad: ${tasks[index].priority}'),
                    Text('ID: ${tasks[index].id}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: AppColors.edit),
                      onPressed: () {
                        context.pushNamed(AppRoute.editTask.name);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: AppColors.primary),
                      onPressed: () {
                        // Aquí puedes implementar la lógica para eliminar la tarea
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
