import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:maidscc_todos_app/core/app_theme/bloc/theme_bloc.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';
import '../../../../../core/route/router_name.dart';
import '../../bloc/update_delete_user_todo/update_delete_user_todo_bloc.dart';

import '../../../../../core/app_theme/app_text_style.dart';
import '../../../../../core/app_theme/app_theme.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/util/snackbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../domain/entities/user_todo.dart';
import 'delete_user_todo_with_dialog_widget.dart';
import 'edit_or_delete_button_widget.dart';

class UserTodoDetailsWidget extends StatelessWidget {
  final UserTodo userTodo;
  const UserTodoDetailsWidget({
    super.key,
    required this.userTodo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        bool swtVal = false;
        if (state is ThemeInitial) {
          swtVal = state.switchVal;
        } else if (state is LoadedThemeState) {
          swtVal = state.switchVal;
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                userTodo.todo,
                style: AppTextStyle.textStyle4.copyWith(
                  fontSize: AppFontSize.fontSizeFortyFour,
                  color: swtVal ? white : black,
                  fontWeight: fontWeightw800,
                ),
              ),
              Divider(height: 50.0.h),
              Center(
                child: Text(
                  userTodo.completed
                      ? "completed".tr(context)
                      : "not completed".tr(context),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.textStyle10.copyWith(
                    color: userTodo.completed ? primaryColor : red,
                  ),
                ),
              ),
              Divider(height: 50.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EditOrDeleteButtonWidget(
                    onPressed: () {
                      GoRouter.of(context)
                          .go('/$updateUserTodoPage?todo=$userTodo');
                    },
                    isColorRedAccent: false,
                    iconData: Icons.edit,
                    btnText: "edit".tr(context),
                  ),
                  EditOrDeleteButtonWidget(
                    onPressed: () => _deleteTodoDialog(context: context),
                    isColorRedAccent: true,
                    iconData: Icons.delete_outline,
                    btnText: "delete".tr(context),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteTodoDialog({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<UpdateDeleteUserTodoBloc,
            UpdateDeleteUserTodoState>(
          listener: (context, state) {
            if (state is SuccessUpdateDeleteUserTodoState) {
              SnackBarMessage.snackBarSuccessMessage(
                context: context,
                message: state.successMessage,
              );
              context.pushReplacementNamed(layoutRoute);
              //context.read<TodosBloc>().add(GetAllTodosEvent());
            } else if (state is ErrorUpdateDeleteUserTodoState) {
              context.pop();
              SnackBarMessage.snackBarErrorMessage(
                context: context,
                message: state.errorMessage,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingUpdateDeleteUserTodoState) {
              return const AlertDialog(
                title: LoadingWidget(),
              );
            }

            return DeleteUserTodoWithDialogWidget(userTodoId: userTodo.id!);
          },
        );
      },
    );
  }
}
