import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/bottom_navigation_bar/presentation/bloc/cubit/bottom_navigation_bar_cubit.dart';
import 'features/settings/presentation/bloc/profile_user_info/profile_user_info_bloc.dart';
import 'features/todos/presentation/bloc/todos/todos_bloc.dart';
import 'features/user_tasks/presentation/bloc/update_delete_user_todo/update_delete_user_todo_bloc.dart';
import 'features/user_tasks/presentation/bloc/user_todos/user_todos_bloc.dart';

import 'core/app_theme/bloc/theme_bloc.dart';
import 'core/extentions/media_query.dart';
import 'core/loaclization/cubit/locale_cubit.dart';
import 'dependency_injection.dart' as di;
import 'features/todos/presentation/bloc/add_update_delete_todo/add_update_delete_todo_bloc.dart';
import 'main.dart';

class TodosMainWidgetApp extends StatelessWidget {
  final FlutterLocalization localization = FlutterLocalization.instance;

  final routesTodos = goRouterProvider.createRoute;

  TodosMainWidgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavigationBarCubit>(
          create: (context) => BottomNavigationBarCubit(),
        ),
        BlocProvider(
          create: (context) => di.sl<TodosBloc>()
            ..add(
              GetAllTodosEvent(),
            ),
        ),
        BlocProvider(create: (_) => di.sl<AddUpdateDeleteTodoBloc>()),
        BlocProvider(
          create: (context) => di.sl<UserTodosBloc>()
            ..add(
              GetAllUserTodosEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => LocaleCubit()..getSavedLanguage(),
        ),
        BlocProvider(
          create: (context) => ThemeBloc()..add(GetCurrentThemeEvent()),
        ),
        BlocProvider(create: (_) => di.sl<UpdateDeleteUserTodoBloc>()),
        BlocProvider(
          create: (context) => di.sl<ProfileUserInfoBloc>()
            ..add(
              GetAllProfileUserInfoEvent(),
            ),
        ),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, statelang) {
          if (statelang is ChangeLocaleLanguageState) {
            return ScreenUtilInit(
              designSize: Size(context.screenWidth, context.screenHeight),
              minTextAdapt: true,
              useInheritedMediaQuery: true,
              builder: (_, child) {
                return BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    if (state is LoadedThemeState) {
                      return MaterialApp.router(
                        debugShowCheckedModeBanner: false,
                        locale: statelang.locale,
                        supportedLocales: localization.supportedLocales,
                        localizationsDelegates:
                            localization.localizationsDelegates,
                        localeResolutionCallback:
                            (deviceLocale, supportedLocales) {
                          for (var locale in supportedLocales) {
                            if (deviceLocale != null &&
                                deviceLocale.languageCode ==
                                    locale.languageCode) {
                              return deviceLocale;
                            }
                          }
                          return supportedLocales.first;
                        },
                        title: 'Todos Application',
                        showSemanticsDebugger: false,
                        restorationScopeId: 'root',
                        routerConfig: routesTodos,
                        theme: state.themeData,
                      );
                    }
                    return const SizedBox();
                  },
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
