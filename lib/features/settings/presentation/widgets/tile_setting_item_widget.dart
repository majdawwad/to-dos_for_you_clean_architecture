import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maidscc_todos_app/core/app_theme/bloc/theme_bloc.dart';
import 'package:maidscc_todos_app/core/loaclization/cubit/locale_cubit.dart';

import '../../../../core/app_theme/app_text_style.dart';
import '../../../../core/app_theme/app_theme.dart';
import '../../../../core/constants/constants.dart';

class TileSettingItemWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final void Function() onTap;
  const TileSettingItemWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
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
        return ListTile(
          title: Text(
            title,
            style: AppTextStyle.textStyle7.copyWith(
              fontWeight: fontWeightw800,
              color: swtVal ? white : black,
            ),
          ),
          subtitle: Text(
            subTitle,
            style: AppTextStyle.textStyle7.copyWith(
              fontWeight: fontWeightw800,
              fontSize: AppFontSize.fontSizeTwelve,
              color: swtVal ? white : black,
            ),
          ),
          trailing: BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, state) {
              if (state is ChangeLocaleLanguageState) {
                return Icon(
                  state.locale == const Locale('en')
                      ? Icons.keyboard_arrow_right
                      : Icons.keyboard_arrow_left,
                  color: grey,
                );
              }
              return const SizedBox();
            },
          ),
          onTap: onTap,
        );
      },
    );
  }
}
