import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks/core/routes/list_routers.dart';
import 'package:tasks/features/tasks/presentation/logic/bloc/bloc/tasks_bloc.dart';
import 'package:tasks/features/tasks/presentation/pages/edit_task.dart';
import 'package:tasks/features/tasks/presentation/pages/home.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      pageBuilder: (context, state) => MaterialPage(
       child: MultiBlocProvider(
          providers: [
            BlocProvider<TasksBloc>(
              create: (context) => GetIt.I.get<TasksBloc>(),
            ),
         
          ],
          child: HomePage(),
        ),
      ),
      routes: [
        GoRoute(
          path: 'editTask',
          name: AppRoute.editTask.name,
          pageBuilder: (context, state) => MaterialPage(
            child: EditPage(),
          ),
        ),
      ],
    ),
  ],
);
