import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks/core/routes/list_routers.dart';
import 'package:tasks/features/tasks/domain/entities/task.dart';
import 'package:tasks/features/tasks/presentation/logic/bloc/bloc/tasks_bloc.dart';

class EditPage extends StatelessWidget {
  EditPage({Key? key, required this.arguments});

  EditParameters arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Tarea'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: EditTaskForm(
          task: arguments.task,
          tasks: arguments.tasks,
        ),
      ),
    );
  }
}

class EditTaskForm extends StatefulWidget {
  const EditTaskForm({super.key, required this.task, required this.tasks});

  final TaskDTO task;
  final List<TaskDTO> tasks;
  @override
  _EditTaskFormState createState() => _EditTaskFormState();
}

class _EditTaskFormState extends State<EditTaskForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priorityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
    _priorityController.text = widget.task.priority;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TasksBloc, TasksState>(
      listener: (context, state) {
        if (state is UpdatedTask) {
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
                  // Aquí puedes implementar la lógica para guardar la tarea editada
                  final taskUpdated = TaskDTO(
                    id: widget.task.id,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    priority: _priorityController.text,
                  );
                  context
                      .read<TasksBloc>()
                      .add(UpdateTask(taskUpdated, widget.tasks));
                  context.pushReplacementNamed(AppRoute.home.name,
                      extra: widget.tasks);
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

class EditParameters {
  EditParameters({required this.task, required this.tasks});
  final TaskDTO task;
  final List<TaskDTO> tasks;
}
