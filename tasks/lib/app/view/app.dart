import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:tasks/core/routes/app_router.dart';
import 'package:tasks/core/theme/app_colors.dart';
import 'package:tasks/counter/counter.dart';
import 'package:tasks/features/tasks/presentation/logic/bloc/bloc/tasks_bloc.dart';
import 'package:tasks/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<TasksBloc>(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            routerConfig: goRouter,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.primaryLigthBackground,
              ),
              useMaterial3: true,
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: const [Locale('en'), Locale('es')],
          );
        },
      ),
    );
  }
}
