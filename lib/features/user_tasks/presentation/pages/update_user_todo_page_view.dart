import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';
import '../../domain/entities/user_todo.dart';
import '../bloc/update_delete_user_todo/update_delete_user_todo_bloc.dart';

import '../../../../core/app_theme/app_theme.dart';
import '../../../../core/route/router_name.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../widgets/update_user_todo_widgets/form_update_widget.dart';

class UpdateUserTodoPageView extends StatefulWidget {
  final dynamic userTodo;

  const UpdateUserTodoPageView({
    super.key,
    this.userTodo,
  });

  @override
  State<UpdateUserTodoPageView> createState() => _UpdateUserTodoPageViewState();
}

class _UpdateUserTodoPageViewState extends State<UpdateUserTodoPageView> {
  late UserTodo userTodoo;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.userTodo != null) {
      // Extracting the values from the input string
      RegExp regex = RegExp(r'UserTodo\((\d+),\s*(.*),\s*(true|false)\)');
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
        "Edit Todo".tr(context),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child:
            BlocConsumer<UpdateDeleteUserTodoBloc, UpdateDeleteUserTodoState>(
          listener: (context, state) {
            if (state is SuccessUpdateDeleteUserTodoState) {
              SnackBarMessage.snackBarSuccessMessage(
                context: context,
                message: state.successMessage,
              );
              context.pushReplacementNamed(layoutRoute);
            } else if (state is ErrorUpdateDeleteUserTodoState) {
              SnackBarMessage.snackBarErrorMessage(
                context: context,
                message: state.errorMessage,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingUpdateDeleteUserTodoState) {
              return const LoadingWidget();
            }
            return FormUpdateWidget(
              userTodo: userTodoo,
            );
          },
        ),
      ),
    );
  }
}
