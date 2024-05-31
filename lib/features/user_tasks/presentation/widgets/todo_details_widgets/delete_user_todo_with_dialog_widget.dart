import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maidscc_todos_app/core/app_theme/app_text_style.dart';
import 'package:maidscc_todos_app/core/app_theme/app_theme.dart';
import 'package:maidscc_todos_app/core/app_theme/bloc/theme_bloc.dart';
import 'package:maidscc_todos_app/core/constants/constants.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';
import '../../bloc/update_delete_user_todo/update_delete_user_todo_bloc.dart';
import 'yes_or_no_button_widget.dart';

class DeleteUserTodoWithDialogWidget extends StatelessWidget {
  final int userTodoId;
  const DeleteUserTodoWithDialogWidget({
    super.key,
    required this.userTodoId,
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
        return AlertDialog(
          backgroundColor: swtVal ? blackDeep : white,
          title: Text(
            "Are you sure?!...".tr(context),
            style: AppTextStyle.textStyle4.copyWith(
              fontSize: AppFontSize.fontSizeTwenty.sp,
              fontWeight: fontWeightw700,
              color: swtVal ? white : black,
            ),
          ),
          actions: [
            YesOrNoButtonWidget(
              btnText: "No".tr(context),
              onPressed: () => Navigator.of(context).pop(),
              color: swtVal ? white : black,
            ),
            YesOrNoButtonWidget(
              btnText: "Yes".tr(context),
              onPressed: () {
                context.read<UpdateDeleteUserTodoBloc>().add(
                      DeleteUserTodoEvent(userTodoId: userTodoId),
                    );
              },
              color: swtVal ? white : black,
            ),
          ],
        );
      },
    );
  }
}
