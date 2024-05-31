import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';
import '../../../../core/app_theme/app_theme.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/todos/todos_bloc.dart';
import '../../../../core/route/router_name.dart';
import '../widgets/todo_details_widgets/todo_details_widget.dart';
import '../widgets/todos_page_widgets/message_display_widget.dart';

class TodoDetailsPageView extends StatelessWidget {
  const TodoDetailsPageView({
    super.key,
  });

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
          context.read<TodosBloc>().add(GetAllTodosEvent());
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
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        switch (state) {
          case LoadingTodoState _:
            return const LoadingWidget();
          case LoadedTodoState _:
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TodoDetailsWidget(todo: state.todo),
              ),
            );
          case ErrorTodoState _:
            return MessageDisplayWidget(
              message: state.errorMessage,
            );
          default:
            return const LoadingWidget();
        }
      },
    );
  }
}
