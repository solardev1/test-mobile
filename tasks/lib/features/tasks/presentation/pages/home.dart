import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks/core/routes/list_routers.dart';
import 'package:tasks/core/theme/app_colors.dart';
import 'package:tasks/core/widgets/custom_app_bard.dart';
import 'package:tasks/features/tasks/domain/entities/task.dart';
import 'package:tasks/features/tasks/presentation/logic/bloc/bloc/tasks_bloc.dart';
import 'package:tasks/features/tasks/presentation/pages/edit_task.dart';

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
      /*    floatingActionButton: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          return FloatingActionButton(
            backgroundColor: AppColors.primary.withOpacity(0.7),
            onPressed: () {
              context.pushNamed(AppRoute.createTask.name,
                  extra: state is TasksLoaded ? state.tasks : widget.tasks);
            },
            child: const Icon(
              Icons.add,
              color: AppColors.low,
            ),
          );
        },
      ), */
    );
  }
}

enum PriorityFilter {
  all,
  alta,
  media,
  baja,
  otras,
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key, required this.tasks});

  final List<TaskDTO> tasks;

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  PriorityFilter _currentFilter = PriorityFilter.all;

  List<TaskDTO> getFilteredTasks() {
    switch (_currentFilter) {
      case PriorityFilter.alta:
        return widget.tasks.where((task) => task.priority == 'Alta').toList();
      case PriorityFilter.media:
        return widget.tasks.where((task) => task.priority == 'Media').toList();
      case PriorityFilter.baja:
        return widget.tasks.where((task) => task.priority == 'Baja').toList();
      case PriorityFilter.otras:
        return widget.tasks
            .where((task) => !['Alta', 'Media', 'Baja'].contains(task.priority))
            .toList();
      default:
        return widget.tasks;
    }
  }

  void showPriorityFilterMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Filtrar por Prioridad'),
          content: DropdownButton<PriorityFilter>(
            value: _currentFilter,
            items: [
              DropdownMenuItem(
                value: PriorityFilter.all,
                child: Text('Todos'),
              ),
              DropdownMenuItem(
                value: PriorityFilter.alta,
                child: Text('Alta'),
              ),
              DropdownMenuItem(
                value: PriorityFilter.media,
                child: Text('Media'),
              ),
              DropdownMenuItem(
                value: PriorityFilter.baja,
                child: Text('Baja'),
              ),
              DropdownMenuItem(
                value: PriorityFilter.otras,
                child: Text('Otras'),
              ),
            ],
            onChanged: (PriorityFilter? value) {
              setState(() {
                _currentFilter = value!;
              });
              Navigator.of(context).pop(); // Cerrar el diálogo
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = getFilteredTasks();
    return Scaffold(
      backgroundColor: AppColors.primaryLigthBackground,
      body: ListView.builder(
        itemCount: filteredTasks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Card(
              child: ListTile(
                title: Text(filteredTasks[index].title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Descripción: ${filteredTasks[index].description}'),
                    Text('Prioridad: ${filteredTasks[index].priority}'),
                    Text('ID: ${filteredTasks[index].id}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: AppColors.edit),
                      onPressed: () {
                        final parameters = EditParameters(
                          task: filteredTasks[index],
                          tasks: filteredTasks,
                        );
                        context.pushNamed(AppRoute.editTask.name,
                            extra: parameters);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: AppColors.primary),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Eliminar tarea'),
                              content: const Text(
                                  '¿Estás seguro de que deseas eliminar esta tarea?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      filteredTasks.removeAt(index);
                                    });
                                    context.pop();
                                  },
                                  child: const Text('Eliminar'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
  floatingActionButton: Stack(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            backgroundColor: AppColors.primary.withOpacity(0.7),
            onPressed: () {
              context.pushNamed(AppRoute.createTask.name, extra: widget.tasks);
            },
            child: const Icon(
              Icons.add,
              color: AppColors.low,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child:  Padding(
            padding: 
            EdgeInsets.only(left: 30.w,),
            child: FloatingActionButton(
            onPressed: () {},
            child: PopupMenuButton<PriorityFilter>(
              onSelected: (PriorityFilter result) {
                setState(() {
                  _currentFilter = result;
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<PriorityFilter>>[
                const PopupMenuItem<PriorityFilter>(
                  value: PriorityFilter.all,
                  child: Text('Todos'),
                ),
                const PopupMenuItem<PriorityFilter>(
                  value: PriorityFilter.alta,
                  child: Text('Alta'),
                ),
                const PopupMenuItem<PriorityFilter>(
                  value: PriorityFilter.media,
                  child: Text('Media'),
                ),
                const PopupMenuItem<PriorityFilter>(
                  value: PriorityFilter.baja,
                  child: Text('Baja'),
                ),
                const PopupMenuItem<PriorityFilter>(
                  value: PriorityFilter.otras,
                  child: Text('Otras'),
                ),
              ],
            ),
            ),
          ),
        ),
      ],
  ),

    );
  }
}
