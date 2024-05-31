import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';

import '../bloc/cubit/bottom_navigation_bar_cubit.dart';
import '../bloc/state/bottom_navigation_bar_state.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavigationCubit = context.watch<BottomNavigationBarCubit>();

    return BottomNavigationBar(
      currentIndex: bottomNavigationCubit.state is BottomNavigationBarHomeState
          ? 0
          : bottomNavigationCubit.state is BottomNavigationBarUserTasksState
              ? 1
              : 2,
      onTap: (index) {
        if (index == 0) {
          bottomNavigationCubit.navigateToHome();
        } else if (index == 1) {
          bottomNavigationCubit.navigateToUserTasks();
        } else if (index == 2) {
          bottomNavigationCubit.navigateToSettings();
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.task_rounded),
          label: 'todos'.tr(context),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.task_alt_outlined),
          label: 'your todos'.tr(context),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: 'settings'.tr(context),
        ),
      ],
    );
  }
}
