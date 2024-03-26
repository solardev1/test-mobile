// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/tasks/data/data_source/tasks_data_source.dart' as _i3;
import '../../features/tasks/data/repo/tasks_repo_impl.dart' as _i6;
import '../../features/tasks/domain/repo/tasks_repo.dart' as _i5;
import '../../features/tasks/presentation/logic/bloc/bloc/tasks_bloc.dart'
    as _i7;
import '../networking/network_client.dart' as _i4;

const String _DEV = 'DEV';
const String _MOCK = 'MOCK';

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.TasksDataSource>(
      () => _i3.TasksDataSourceImpl(networkClient: gh<_i4.NetworkClient>()),
      registerFor: {
        _DEV,
        _MOCK,
      },
    );
    gh.singleton<_i5.TasksRepository>(
        () => _i6.TaskRespositoryimpl(dataSource: gh<_i3.TasksDataSource>()));
    gh.factory<_i7.TasksBloc>(() => _i7.TasksBloc(gh<_i5.TasksRepository>()));
    return this;
  }
}
