import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';
import '../../../../../core/app_theme/app_text_style.dart';
import '../../../../../core/app_theme/app_theme.dart';
import '../../../../../core/app_theme/bloc/theme_bloc.dart';
import '../../../../../core/route/router_name.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../domain/entities/todo.dart';
import '../../bloc/todos/todos_bloc.dart';

class TodosWidget extends StatefulWidget {
  final List<Todo> todos;
  final bool hasReachedMax;
  const TodosWidget({
    super.key,
    required this.todos,
    required this.hasReachedMax,
  });

  @override
  State<TodosWidget> createState() => _TodosWidgetState();
}

class _TodosWidgetState extends State<TodosWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9)) {
      context.read<TodosBloc>().add(GetAllTodosEvent());
    }
  }

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
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return index >= widget.todos.length
                ? const LoadingWidget()
                : ListTile(
                    leading: CircleAvatar(
                      backgroundColor: primaryColor,
                      child: Text(
                        widget.todos[index].id.toString(),
                        style: AppTextStyle.textStyle4.copyWith(
                          fontSize: AppFontSize.fontSizeTwenty,
                        ),
                      ),
                    ),
                    title: Text(
                      widget.todos[index].todo.toString(),
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
                            borderRadius: BorderRadius.all(
                                Radius.circular(defaultRadius.r))),
                        child: Center(
                          child: Text(
                            widget.todos[index].completed
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
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: AppPadding.paddingTen.w),
                    onTap: () {
                      context
                          .read<TodosBloc>()
                          .add(GetTodoEvent(todoId: widget.todos[index].id!));
                      context.pushReplacementNamed(todoDetailsRoute);
                    },
                  );
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 1.0.h,
              color: primaryColor,
            );
          },
          itemCount: widget.hasReachedMax
              ? widget.todos.length
              : widget.todos.length + 1,
        );
      },
    );
  }
}
