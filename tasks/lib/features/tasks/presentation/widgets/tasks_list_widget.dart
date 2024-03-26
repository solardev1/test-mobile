import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks/core/routes/list_routers.dart';
import 'package:tasks/core/theme/app_colors.dart';
import 'package:tasks/core/utils/tasks_utils.dart';
import 'package:tasks/features/tasks/domain/entities/task.dart';
import 'package:tasks/features/tasks/presentation/logic/bloc/bloc/tasks_bloc.dart';
import 'package:tasks/features/tasks/presentation/pages/edit_task.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({required this.tasks, super.key});

  final List<TaskDTO> tasks;

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  PriorityFilter _currentFilter = PriorityFilter.all;

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
              shadowColor: AppColors.primary.withOpacity(0.5),
              elevation: 7,
              child: ListTile(
                title: Text(filteredTasks[index].title,
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Descripción: ${filteredTasks[index].description}',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w600)),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: filteredTasks[index].priority == 'Alta'
                            ? AppColors.primary.withOpacity(0.2)
                            : filteredTasks[index].priority == 'Media'
                                ? AppColors.medium.withOpacity(0.2)
                                : filteredTasks[index].priority == 'Baja'
                                    ? AppColors.low.withOpacity(0.2)
                                    : AppColors.selectedColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text('Prioridad: ${filteredTasks[index].priority}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: filteredTasks[index].priority == 'Alta'
                                  ? AppColors.primary
                                  : filteredTasks[index].priority == 'Media'
                                      ? AppColors.medium
                                      : filteredTasks[index].priority == 'Baja'
                                          ? AppColors.low
                                          : AppColors.selectedColor)),
                    ),
                    Text('ID: ${filteredTasks[index].id}',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w400)),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon:
                          Icon(Icons.edit, color: AppColors.edit, size: 28.sp),
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
                      icon: Icon(Icons.delete_rounded,
                          color: AppColors.primary, size: 28.sp),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Eliminar tarea',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600)),
                              content: Text(
                                  '¿Estás seguro de que deseas eliminar esta tarea?',
                                  style: TextStyle(fontSize: 16.sp)),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: Text('Cancelar',
                                      style: TextStyle(fontSize: 14.sp)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      filteredTasks.removeAt(index);
                                    });
                                    context.pop();
                                  },
                                  child: Text('Eliminar',
                                      style: TextStyle(fontSize: 14.sp)),
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
      floatingActionButton: CustomActionsButton(),
    );
  }

  Stack CustomActionsButton() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              return FloatingActionButton(
                backgroundColor: AppColors.primary.withOpacity(0.8),
                onPressed: () {
                  context.pushNamed(AppRoute.createTask.name,
                      extra: state is TasksLoaded ? state.tasks : widget.tasks);
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.only(
              left: 35.w,
            ),
            child: FloatingActionButton(
              backgroundColor: AppColors.secondary.withOpacity(0.8),
              onPressed: () {},
              child: PopupMenuButton<PriorityFilter>(
                icon: Icon(Icons.filter_list_rounded,
                    color: Colors.white, size: 28.sp),
                onSelected: (PriorityFilter result) {
                  setState(() {
                    _currentFilter = result;
                  });
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<PriorityFilter>>[
                  PopupMenuItem<PriorityFilter>(
                    value: PriorityFilter.all,
                    child: Text('Todos', style: TextStyle(fontSize: 14.sp)),
                  ),
                  PopupMenuItem<PriorityFilter>(
                    value: PriorityFilter.alta,
                    child: Text('Alta', style: TextStyle(fontSize: 14.sp)),
                  ),
                  PopupMenuItem<PriorityFilter>(
                    value: PriorityFilter.media,
                    child: Text('Media', style: TextStyle(fontSize: 14.sp)),
                  ),
                  PopupMenuItem<PriorityFilter>(
                    value: PriorityFilter.baja,
                    child: Text('Baja', style: TextStyle(fontSize: 14.sp)),
                  ),
                  PopupMenuItem<PriorityFilter>(
                    value: PriorityFilter.otras,
                    child: Text('Otras', style: TextStyle(fontSize: 14.sp)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

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
}
