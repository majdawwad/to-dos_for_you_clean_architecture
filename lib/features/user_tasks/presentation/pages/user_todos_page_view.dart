import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';
import '../../../../core/constants/constants.dart';
import '../bloc/user_todos/user_todos_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../widgets/user_todos_page_widgets/message_display_widget.dart';
import '../widgets/user_todos_page_widgets/user_todos_widget.dart';

class UserTodosPageView extends StatelessWidget {
  const UserTodosPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: null,
      title: Text(
        "your todos".tr(context),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.paddingTen.w,
        vertical: AppPadding.paddingTen.h,
      ),
      child: BlocBuilder<UserTodosBloc, UserTodosState>(
        builder: (context, state) {
          if (state is LoadingUserTodoState) {
            return const LoadingWidget();
          } else if (state is LoadedUserTodoState) {
            return UserTodosWidget(
              userTodos: state.userTodos,
            );
          } else if (state is ErrorUserTodoState) {
            return MessageDisplayWidget(
              message: state.message,
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}
