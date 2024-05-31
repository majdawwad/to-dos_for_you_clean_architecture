import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';
import '../../../../core/constants/constants.dart';

import '../../../../core/app_theme/app_theme.dart';
import '../../../../core/route/router_name.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/todos/todos_bloc.dart';
import '../widgets/todos_page_widgets/message_display_widget.dart';
import '../widgets/todos_page_widgets/todos_widget.dart';

class TodosPageView extends StatelessWidget {
  const TodosPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(context: context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: null,
      title: Text(
        "todos".tr(context),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.paddingTen.w,
        vertical: AppPadding.paddingTen.h,
      ),
      child: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          if (state.status == TodoStatus.loading) {
            return const LoadingWidget();
          } else if (state.status == TodoStatus.success) {
            return RefreshIndicator(
              color: primaryColor,
              backgroundColor: grey,
              semanticsLabel: "Loadiing...",
              onRefresh: () => _onRefresh(context: context),
              child: TodosWidget(
                todos: state.todos,
                hasReachedMax: state.hasReachedMax,
              ),
            );
          } else if (state.status == TodoStatus.error) {
            return MessageDisplayWidget(
              message: state.errorMessage,
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Widget _buildFloatingButton({
    required BuildContext context,
  }) {
    return FloatingActionButton(
      onPressed: () {
        GoRouter.of(context).go('/$addOrUpdateTodoPage?isUpdateTodo=false');
      },
      child: const Icon(
        Icons.add,
        color: white,
      ),
    );
  }

  Future<void> _onRefresh({
    required BuildContext context,
  }) async {
    context.read<TodosBloc>().add(RefreshAllTodosEvent());
  }
}
