import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks/core/routes/list_routers.dart';
import 'package:tasks/core/theme/app_colors.dart';
import 'package:tasks/core/utils/tasks_utils.dart';
import 'package:tasks/features/tasks/domain/entities/task.dart';
import 'package:tasks/features/tasks/presentation/logic/bloc/bloc/tasks_bloc.dart';
import 'package:uuid/uuid.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({required this.tasks, super.key});

  final List<TaskDTO> tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLigthBackground,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
        ),
        title: Text('Crear Tarea',
            style: TextStyle(fontSize: 20.sp, color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: CreateTaskForm(tasks: tasks),
      ),
    );
  }
}

class CreateTaskForm extends StatefulWidget {
  const CreateTaskForm({required this.tasks, super.key});

  final List<TaskDTO> tasks;

  @override
  _CreateTaskFormState createState() => _CreateTaskFormState();
}

class _CreateTaskFormState extends State<CreateTaskForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TasksBloc, TasksState>(
      listener: (context, state) {
        if (state is CreatedTask) {
          context.pushReplacementNamed(AppRoute.home.name, extra: state.tasks);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                  labelText: 'Título',
                  labelStyle: TextStyle(
                    fontSize: 16.sp,
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa un título';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                  labelText: 'Descripción',
                  labelStyle: TextStyle(
                    fontSize: 16.sp,
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa una descripción';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priorityController,
              decoration: InputDecoration(
                  labelText: 'Prioridad',
                  labelStyle: TextStyle(
                    fontSize: 16.sp,
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa una prioridad';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newTask = TaskDTO(
                    id: const Uuid().v4().substring(0, 8),
                    title: _titleController.text,
                    description: _descriptionController.text,
                    priority: _priorityController.text.capitalize(),
                  );
                  context
                      .read<TasksBloc>()
                      .add(CreateTask(newTask, widget.tasks));
                }
              },
              child: Text('Guardar',
                  style: TextStyle(
                    fontSize: 16.sp,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priorityController.dispose();
    super.dispose();
  }
}
