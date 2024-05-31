import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';

import '../../../../core/app_theme/app_theme.dart';
import '../../../../core/route/router_name.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/todo.dart';
import '../bloc/add_update_delete_todo/add_update_delete_todo_bloc.dart';
import '../bloc/todos/todos_bloc.dart';
import '../widgets/add_or_update_todo_widgets/form_add_or_update_widget.dart';

class AddOrUpdateTodoPageView extends StatefulWidget {
  final dynamic todo;
  final dynamic isUpdateTodo;

  const AddOrUpdateTodoPageView({
    super.key,
    this.todo,
    required this.isUpdateTodo,
  });

  @override
  State<AddOrUpdateTodoPageView> createState() =>
      _AddOrUpdateTodoPageViewState();
}

class _AddOrUpdateTodoPageViewState extends State<AddOrUpdateTodoPageView> {
  Todo? todoo;
  late bool isUpdateTodoo;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.todo != null) {
      // Remove the initial part and closing parenthesis
      String todoData = widget.todo.substring(
          widget.todo.indexOf('(') + 1, widget.todo.lastIndexOf(')'));

// Split the remaining string using comma as the delimiter
      List<String> todoComponents = todoData.split(',');

// Trim leading and trailing spaces from each component
      List<String> trimmedComponents =
          todoComponents.map((component) => component.trim()).toList();
      todoo = Todo(
        id: int.parse(trimmedComponents[0]),
        todo: Uri.decodeFull(trimmedComponents[1]),
        completed: (trimmedComponents[2].toLowerCase() == 'true'),
      );
    }

    isUpdateTodoo = bool.parse(widget.isUpdateTodo);

    log(widget.isUpdateTodo.toString());
    log(widget.todo != null ? todoo!.todo.toString() : "null");
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
          if (isUpdateTodoo) {
            context.pushNamed(todoDetailsRoute);
          } else {
            context.pushReplacementNamed(layoutRoute);
            context.read<TodosBloc>().add(GetAllTodosEvent());
          }
        },
        icon: const Icon(
          Icons.arrow_back,
          color: white,
        ),
      ),
      title: Text(
        isUpdateTodoo ? "Edit Todo".tr(context) : "Add Todo".tr(context),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<AddUpdateDeleteTodoBloc, AddUpdateDeleteTodoState>(
          listener: (context, state) {
            if (state is SuccessAddUpdateDeleteTodoState) {
              SnackBarMessage.snackBarSuccessMessage(
                context: context,
                message: state.successMessage,
              );
              context.pushReplacementNamed(layoutRoute);
              context.read<TodosBloc>().add(GetAllTodosEvent());
            } else if (state is ErrorAddUpdateDeleteTodoState) {
              SnackBarMessage.snackBarErrorMessage(
                context: context,
                message: state.errorMessage,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingAddUpdateDeleteTodoState) {
              return const LoadingWidget();
            }
            return FormAddOrUpdateWidget(
              isUpdateTodo: isUpdateTodoo,
              todo: isUpdateTodoo ? todoo : null,
            );
          },
        ),
      ),
    );
  }
}
