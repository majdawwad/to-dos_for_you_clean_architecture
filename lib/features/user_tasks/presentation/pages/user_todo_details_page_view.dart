import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';

import '../../../../core/app_theme/app_theme.dart';
import '../../domain/entities/user_todo.dart';

import '../../../../core/route/router_name.dart';
import '../widgets/todo_details_widgets/user_todo_details_widget.dart';

class UserTodoDetailsPageView extends StatefulWidget {
  final dynamic userTodo;
  const UserTodoDetailsPageView({
    super.key,
    required this.userTodo,
  });

  @override
  State<UserTodoDetailsPageView> createState() =>
      _UserTodoDetailsPageViewState();
}

class _UserTodoDetailsPageViewState extends State<UserTodoDetailsPageView> {
  late UserTodo userTodoo;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.userTodo != null) {
      // Extracting the values from the input string
      RegExp regex = RegExp(r'UserTodoModel\((\d+),\s*(.*),\s*(true|false)\)');
      Match? match = regex.firstMatch(widget.userTodo);

      if (match != null) {
        int id = int.parse(match.group(1)!);
        String todo = match.group(2)!;
        bool completed = match.group(3)! == 'true';

        // Create the UserTodo object
        userTodoo = UserTodo(id: id, todo: todo, completed: completed);

        // Print the UserTodo object
        log(userTodoo.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.pushReplacementNamed(layoutRoute);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: white,
        ),
      ),
      title: Text(
        "todo details".tr(context),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: UserTodoDetailsWidget(
          userTodo: userTodoo,
        ),
      ),
    );
  }
}
