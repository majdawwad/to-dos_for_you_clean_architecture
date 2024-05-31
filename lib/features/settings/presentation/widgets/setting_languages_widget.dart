import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maidscc_todos_app/core/app_theme/bloc/theme_bloc.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';

import '../../../../core/app_theme/app_text_style.dart';
import '../../../../core/app_theme/app_theme.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/loaclization/cubit/locale_cubit.dart';

class SettingLanguagesWidget extends StatelessWidget {
  const SettingLanguagesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          if (state is ChangeLocaleLanguageState) {
            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, stateTheme) {
                bool swtVal = false;
                if (stateTheme is ThemeInitial) {
                  swtVal = stateTheme.switchVal;
                } else if (stateTheme is LoadedThemeState) {
                  swtVal = stateTheme.switchVal;
                }
                return Container(
                  decoration: BoxDecoration(
                      color: swtVal ? blackDeep : white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(radiusSeventeen.r),
                          topLeft: Radius.circular(radiusSeventeen.r)),
                      border: Border.all(color: white)),
                  height: context.screenHeight * 0.3,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: AppPadding.paddingTwenty.w,
                      end: AppPadding.paddingTwenty.w,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: AppPadding.paddingTwenty.w,
                        end: AppPadding.paddingTwenty.w,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Settings To Change Languages".tr(context),
                              style: AppTextStyle.textStyle7.copyWith(
                                fontWeight: fontWeightw800,
                                color: swtVal ? white : black,
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              context.read<LocaleCubit>().changeLanguage("en");
                            },
                            title: Text(
                              "English Language".tr(context),
                              style: AppTextStyle.textStyle7.copyWith(
                                fontWeight: fontWeightw800,
                                fontSize: AppFontSize.fontSizeTwelve,
                                color: state.locale == const Locale("en")
                                    ? primaryColor
                                    : swtVal
                                        ? white
                                        : grey,
                              ),
                            ),
                            trailing: Icon(
                              Icons.language_outlined,
                              color: state.locale == const Locale("en")
                                  ? primaryColor
                                  : swtVal
                                      ? white
                                      : grey,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              context.read<LocaleCubit>().changeLanguage("ar");
                            },
                            title: Text(
                              "Arabic Language".tr(context),
                              style: AppTextStyle.textStyle7.copyWith(
                                fontWeight: fontWeightw800,
                                fontSize: AppFontSize.fontSizeTwelve,
                                color: state.locale == const Locale("ar")
                                    ? primaryColor
                                    : swtVal
                                        ? white
                                        : grey,
                              ),
                            ),
                            trailing: Icon(
                              Icons.language_outlined,
                              color: state.locale == const Locale("ar")
                                  ? primaryColor
                                  : swtVal
                                      ? white
                                      : grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      );
    });
  }
}
