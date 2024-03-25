import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks/core/routes/list_routers.dart';
import 'package:tasks/features/tasks/domain/entities/task.dart';
import 'package:tasks/features/tasks/presentation/logic/bloc/bloc/tasks_bloc.dart';
import 'package:uuid/uuid.dart';


class CreatePage extends StatelessWidget {
  CreatePage({Key? key, required this.tasks});

  final List<TaskDTO> tasks;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Tarea'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CreateTaskForm( tasks: tasks),
      ),
    );
  }
}

class CreateTaskForm extends StatefulWidget {
  const CreateTaskForm({Key? key, required this.tasks});


  final List<TaskDTO> tasks;

  @override
  _CreateTaskFormState createState() => _CreateTaskFormState();
}

class _CreateTaskFormState extends State<CreateTaskForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priorityController = TextEditingController();

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
              decoration: InputDecoration(labelText: 'Título'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa un título';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa una descripción';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priorityController,
              decoration: InputDecoration(labelText: 'Prioridad'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa una prioridad';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newTask = TaskDTO(
                    id:  const Uuid().v4().substring(0, 8),
                    title: _titleController.text,
                    description: _descriptionController.text,
                    priority: _priorityController.text,
                  );
                  context.read<TasksBloc>().add(CreateTask(newTask, widget.tasks));
                }
              },
              child: Text('Guardar'),
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
