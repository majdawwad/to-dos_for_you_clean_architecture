import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maidscc_todos_app/core/app_theme/app_text_style.dart';
import 'package:maidscc_todos_app/core/app_theme/app_theme.dart';

import '../../../../../core/app_theme/bloc/theme_bloc.dart';

class MessageDisplayWidget extends StatelessWidget {
  final String message;
  const MessageDisplayWidget({
    super.key,
    required this.message,
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
        return SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: Center(
            child: SingleChildScrollView(
              child: Text(
                message,
                style: AppTextStyle.textStyle1.copyWith(
                  fontWeight: fontWeightw700,
                  color: swtVal ? white : black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
