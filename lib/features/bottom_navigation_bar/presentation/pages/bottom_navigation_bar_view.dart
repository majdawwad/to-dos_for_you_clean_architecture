import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../todos/presentation/pages/todos_page_view.dart';

import '../../../settings/presentation/pages/settings_view.dart';
import '../../../user_tasks/presentation/pages/user_todos_page_view.dart';
import '../bloc/cubit/bottom_navigation_bar_cubit.dart';
import '../bloc/state/bottom_navigation_bar_state.dart';
import '../widgets/bottom_navigation_bar_widget.dart';

class BottomNavigationBarView extends StatelessWidget {
  const BottomNavigationBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
        builder: (context, state) {
          if (state is BottomNavigationBarHomeState) {
            return const TodosPageView();
          } else if (state is BottomNavigationBarUserTasksState) {
            return const UserTodosPageView();
          } else if (state is BottomNavigationBarSettingsState) {
            return const SettingsView();
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
