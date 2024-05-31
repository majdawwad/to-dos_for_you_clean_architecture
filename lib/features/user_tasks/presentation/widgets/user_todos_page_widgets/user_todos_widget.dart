import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:maidscc_todos_app/core/app_theme/bloc/theme_bloc.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';

import '../../../../../core/app_theme/app_text_style.dart';
import '../../../../../core/app_theme/app_theme.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/route/router_name.dart';
import '../../../domain/entities/user_todo.dart';

class UserTodosWidget extends StatelessWidget {
  final List<UserTodo> userTodos;
  const UserTodosWidget({super.key, required this.userTodos});

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
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: primaryColor,
                child: Text(
                  userTodos[index].id.toString(),
                  style: AppTextStyle.textStyle4.copyWith(
                    fontSize: AppFontSize.fontSizeTwenty,
                  ),
                ),
              ),
              title: Text(
                userTodos[index].todo.toString(),
                style: AppTextStyle.textStyle4.copyWith(
                  fontSize: AppFontSize.fontSizeTwenty,
                  color: swtVal ? white : black,
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppPadding.paddingTwenty.h,
                ),
                child: Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius:
                          BorderRadius.all(Radius.circular(defaultRadius.r))),
                  child: Center(
                    child: Text(
                      userTodos[index].completed
                          ? "completed".tr(context)
                          : "not completed".tr(context),
                      textAlign: TextAlign.center,
                      style: AppTextStyle.textStyle10.copyWith(
                        color: white,
                      ),
                    ),
                  ),
                ),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: AppPadding.paddingTen.w),
              onTap: () {
                GoRouter.of(context)
                    .go('/$userTodoDetailsRoute?todo=${userTodos[index]}');
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 1.0.h,
              color: primaryColor,
            );
          },
          itemCount: userTodos.length,
        );
      },
    );
  }
}
