import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'features/settings/data/repositories/profile_user_repository_implement.dart';
import 'features/settings/domain/repositories/profile_user_repository.dart';
import 'features/settings/domain/usecases/get_all_profile_user_info.dart';
import 'features/settings/presentation/bloc/profile_user_info/profile_user_info_bloc.dart';
import 'features/todos/data/repositories/todo_repository_implement.dart';
import 'features/todos/domain/repositories/todos_repository.dart';
import 'features/todos/domain/usecases/get_all_todos.dart';
import 'features/todos/presentation/bloc/todos/todos_bloc.dart';
import 'features/user_tasks/domain/usecases/get_all_user_todos.dart';
import 'features/user_tasks/domain/usecases/update_user_todo.dart';
import 'features/user_tasks/presentation/bloc/update_delete_user_todo/update_delete_user_todo_bloc.dart';
import 'features/auth/data/data_sources/remote_data_source.dart' as auth;
import 'features/todos/data/data_sources/remote_data_source.dart' as todos;
import 'features/user_tasks/data/data_sources/remote_data_source.dart'
    as remote_user_todoss;
import 'features/user_tasks/data/data_sources/local_data_source.dart'
    as local_user_todoss;
import 'features/settings/data/data_sources/local_data_source.dart'
    as local_profile_user;
import 'features/settings/data/data_sources/remote_date_source.dart'
    as remote_profile_user;
import 'features/auth/data/repositories/auth_repository_implement.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/sign_in.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/todos/data/data_sources/local_data_source.dart';
import 'features/todos/domain/usecases/add_todo.dart';
import 'features/todos/domain/usecases/delete_todo.dart';
import 'features/todos/domain/usecases/get_todo.dart';
import 'features/todos/domain/usecases/update_todo.dart';
import 'features/todos/presentation/bloc/add_update_delete_todo/add_update_delete_todo_bloc.dart';
import 'features/user_tasks/data/repositories/user_todo_repository_implement.dart';
import 'features/user_tasks/domain/repositories/user_todos_repository.dart';
import 'features/user_tasks/domain/usecases/delete_user_todo.dart';
import 'features/user_tasks/presentation/bloc/user_todos/user_todos_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Auth

  //Bloc
  sl.registerFactory(
    () => AuthBloc(signInUseCase: sl()),
  );

  //UseCases
  sl.registerLazySingleton(() => SignInUseCase(sl()));

  //Auth Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImplement(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //Data Sources
  sl.registerLazySingleton<auth.RemoteDataSource>(
    () => auth.RemoteDataSourceImplement(client: sl(), sharedPreferences: sl()),
  );

  //! Features - Todo Text

  //Bloc
  sl.registerFactory(
      () => TodosBloc(getAllTodosUseCase: sl(), getTodoUseCase: sl()));
  sl.registerFactory(
    () => AddUpdateDeleteTodoBloc(
      addTodoUseCase: sl(),
      updateTodoUseCase: sl(),
      deleteTodoUseCase: sl(),
    ),
  );

  //Use case
  sl.registerLazySingleton(() => GetAllTodosUseCase(sl()));
  sl.registerLazySingleton(() => GetTodoUseCase(sl()));
  sl.registerLazySingleton(() => AddTodoUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTodoUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTodoUseCase(sl()));

  //Tod Repository
  sl.registerLazySingleton<TodosRepository>(
    () => TodoRepositoryImplement(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //Data Sources
  sl.registerLazySingleton<todos.RemoteDataSource>(
      () => todos.RemoteDataSourceImplement(client: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImplement(sharedPreferences: sl()));

  //! Features - User Todos

  //Bloc
  sl.registerFactory(() => UserTodosBloc(getAllUserTodosUseCase: sl()));
  sl.registerFactory(
    () => UpdateDeleteUserTodoBloc(
      updateUserTodoUseCase: sl(),
      deleteUserTodoUseCase: sl(),
    ),
  );

  //Use case
  sl.registerLazySingleton(() => GetAllUserTodosUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserTodoUseCase(sl()));
  sl.registerLazySingleton(() => DeleteUserTodoUseCase(sl()));

  //Tod Repository
  sl.registerLazySingleton<UserTodosRepository>(
    () => UserTodoRepositoryImplement(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //Data Sources
  sl.registerLazySingleton<remote_user_todoss.RemoteDataSource>(
      () => remote_user_todoss.RemoteDataSourceImplement(client: sl()));
  sl.registerLazySingleton<local_user_todoss.LocalDataSource>(() =>
      local_user_todoss.LocalDataSourceImplement(sharedPreferences: sl()));

  //! Profile User Info

  //Bloc
  sl.registerFactory(
      () => ProfileUserInfoBloc(getAllProfileUserInfoUseCase: sl()));

  //Use case
  sl.registerLazySingleton(() => GetAllProfileUserInfoUseCase(sl()));

  //Tod Repository
  sl.registerLazySingleton<ProfileUserRepository>(
    () => ProfileUserRepositoryImplement(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //Data Sources
  sl.registerLazySingleton<remote_profile_user.RemoteDataSource>(
      () => remote_profile_user.RemoteDataSourceImplement(client: sl()));
  sl.registerLazySingleton<local_profile_user.LocalDataSource>(() =>
      local_profile_user.LocalDataSourceImplement(sharedPreferences: sl()));

  //! core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplement(sl()));

  //! External

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
