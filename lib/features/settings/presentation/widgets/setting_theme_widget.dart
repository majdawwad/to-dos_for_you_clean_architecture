import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';

import '../../../../core/app_theme/app_text_style.dart';
import '../../../../core/app_theme/app_theme.dart';
import '../../../../core/app_theme/bloc/theme_bloc.dart';
import '../../../../core/constants/constants.dart';

class SettingThemeWidget extends StatelessWidget {
  const SettingThemeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          bool swtVal = false;
          if (state is ThemeInitial) {
            swtVal = state.switchVal;
          } else if (state is LoadedThemeState) {
            swtVal = state.switchVal;
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
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Settings To Change Theme".tr(context),
                      style: AppTextStyle.textStyle7.copyWith(
                        fontWeight: fontWeightw800,
                        color: swtVal ? white : black,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.light_mode,
                        color: !swtVal ? primaryColor : white,
                      ),
                      Text(
                        "Light".tr(context),
                        style: AppTextStyle.textStyle7.copyWith(
                          fontWeight: fontWeightw800,
                          fontSize: AppFontSize.fontSizeTwelve,
                          color: !swtVal ? primaryColor : white,
                        ),
                      ),
                      CupertinoSwitch(
                        activeColor: green,
                        trackColor: grey,
                        value: swtVal,
                        onChanged: (_) {
                          if (swtVal) {
                            context.read<ThemeBloc>().add(
                                  ThemeChangedEvent(
                                    theme: AppTheme.values.first,
                                    switchVal: swtVal,
                                  ),
                                );
                          } else {
                            context.read<ThemeBloc>().add(
                                  ThemeChangedEvent(
                                    theme: AppTheme.values.last,
                                    switchVal: swtVal,
                                  ),
                                );
                          }
                        },
                      ),
                      Icon(
                        Icons.dark_mode,
                        color: swtVal ? primaryColor : grey,
                      ),
                      Text(
                        "Dark".tr(context),
                        style: AppTextStyle.textStyle7.copyWith(
                          fontWeight: fontWeightw800,
                          fontSize: AppFontSize.fontSizeTwelve,
                          color: swtVal ? primaryColor : grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
