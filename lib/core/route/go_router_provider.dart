import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maidscc_todos_app/features/settings/presentation/pages/profile_user_info_view.dart';
import 'package:maidscc_todos_app/features/settings/presentation/pages/settings_view.dart';

import '../../features/todos/presentation/pages/todo_details_page_view.dart';
import '../../features/todos/presentation/pages/todos_page_view.dart';
import '../../features/bottom_navigation_bar/presentation/pages/bottom_navigation_bar_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/pages/sign_in/sign_in_page_view.dart';
import '../../features/splash/presentation/pages/splash_page_view.dart';
import '../../features/todos/presentation/pages/add_or_update_todo_page_view.dart';
import '../../features/user_tasks/presentation/pages/update_user_todo_page_view.dart';
import '../../features/user_tasks/presentation/pages/user_todo_details_page_view.dart';
import '../../features/user_tasks/presentation/pages/user_todos_page_view.dart';
import '../constants/constants.dart';
import '../util/app_transition.dart';
import 'router_name.dart';

class GoRouterProvider {
  bool isLogInUser = false;

  Future<void> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogInUser = prefs.getBool(isLogin) ?? false;
  }

  GoRouter get createRoute {
    return GoRouter(
      initialLocation: isLogInUser
          ? '/$layoutRoute'
          : !isLogInUser
              ? '/'
              : '/',
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (BuildContext context, state) {
            return AppTransition.customTransition(
                state, const SplashPageView());
          },
        ),
        GoRoute(
            path: '/layout-page',
            name: layoutRoute,
            pageBuilder: (BuildContext context, state) {
              return AppTransition.customTransition(
                  state, const BottomNavigationBarView());
            }),
        GoRoute(
            path: '/sign-in-page',
            name: signInRoute,
            pageBuilder: (BuildContext context, state) {
              return AppTransition.customTransition(
                  state, const SignInPageView());
            }),
        GoRoute(
          path: '/todo-text-page',
          name: todoTextRoute,
          pageBuilder: (BuildContext context, state) {
            return AppTransition.customTransition(state, const TodosPageView());
          },
        ),
        GoRoute(
          path: '/todo-details-page',
          name: todoDetailsRoute,
          pageBuilder: (BuildContext context, state) {
            return AppTransition.customTransition(
                state, const TodoDetailsPageView());
          },
        ),
        GoRoute(
          path: '/add-or-update-todo-page',
          name: addOrUpdateTodoPage,
          pageBuilder: (BuildContext context, state) {
            final todo = state.queryParams['todo'];
            final isUpdateTodo = state.queryParams['isUpdateTodo'];
            return AppTransition.customTransition(
                state,
                AddOrUpdateTodoPageView(
                  todo: todo,
                  isUpdateTodo: isUpdateTodo,
                ));
          },
        ),
        GoRoute(
          path: '/user-todo-page',
          name: userTodoRoute,
          pageBuilder: (BuildContext context, state) {
            return AppTransition.customTransition(
                state, const UserTodosPageView());
          },
        ),
        GoRoute(
          path: '/user-todo-details-page',
          name: userTodoDetailsRoute,
          pageBuilder: (BuildContext context, state) {
            final userTodo = state.queryParams['todo'];
            return AppTransition.customTransition(
              state,
              UserTodoDetailsPageView(
                userTodo: userTodo,
              ),
            );
          },
        ),
        GoRoute(
          path: '/update-user-todo-page',
          name: updateUserTodoPage,
          pageBuilder: (BuildContext context, state) {
            final todo = state.queryParams['todo'];
            return AppTransition.customTransition(
                state,
                UpdateUserTodoPageView(
                  userTodo: todo,
                ));
          },
        ),
        GoRoute(
          path: '/settings-page',
          name: settingsRoute,
          pageBuilder: (BuildContext context, state) {
            return AppTransition.customTransition(state, const SettingsView());
          },
        ),
        GoRoute(
          path: '/profile-user-info',
          name: profileUserInfo,
          pageBuilder: (BuildContext context, state) {
            return AppTransition.customTransition(
                state, const ProfileUserInfoView());
          },
        ),
      ],
    );
  }
}
