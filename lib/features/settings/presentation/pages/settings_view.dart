import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:maidscc_todos_app/core/app_theme/app_theme.dart';
import 'package:maidscc_todos_app/core/constants/constants.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';
import 'package:maidscc_todos_app/core/widgets/loading_widget.dart';
import 'package:maidscc_todos_app/features/settings/presentation/bloc/profile_user_info/profile_user_info_bloc.dart';
import 'package:maidscc_todos_app/features/settings/presentation/widgets/profile_image_and_name_item_widget.dart';
import 'package:maidscc_todos_app/features/settings/presentation/widgets/tile_setting_item_widget.dart';
import 'package:maidscc_todos_app/features/todos/presentation/widgets/todos_page_widgets/message_display_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/route/router_name.dart';
import '../widgets/setting_languages_widget.dart';
import '../widgets/setting_theme_widget.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late SharedPreferences sharedPreferences;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  showThemeModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius.r)),
      context: context,
      builder: (context) {
        return const SettingThemeWidget();
      },
    );
  }

  showLanguageModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius.r)),
      context: context,
      builder: (context) {
        return const SettingLanguagesWidget();
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: null,
      title: Text(
        "settings".tr(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.paddingThirty.w,
        vertical: AppPadding.paddingThirty.h,
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 30.0.h),
          BlocBuilder<ProfileUserInfoBloc, ProfileUserInfoState>(
            builder: (context, state) {
              if (state is LoadingProfileUserState) {
                return const LoadingWidget();
              } else if (state is LoadedProfileUserInfoState) {
                return ProfileImageAndNameItemWidget(
                  decorationColor: primaryColor,
                  imageRoute: state.profileUser.image,
                  borderColor: primaryColor,
                  nameColor: primaryColor,
                  fLname:
                      "${state.profileUser.firstName} ${state.profileUser.lastName}",
                  userName: state.profileUser.userName,
                  width: 120,
                  height: 120,
                );
              } else if (state is ErrorProfileUserInfoState) {
                return MessageDisplayWidget(message: state.message);
              }
              return const SizedBox();
            },
          ),
          SizedBox(height: 20.0.h),
          TileSettingItemWidget(
            title: "themes".tr(context),
            subTitle: "change your theme".tr(context),
            onTap: () => showThemeModalBottomSheet(context),
          ),
          TileSettingItemWidget(
            title: "languages".tr(context),
            subTitle: "choose your language".tr(context),
            onTap: () => showLanguageModalBottomSheet(context),
          ),
          BlocBuilder<ProfileUserInfoBloc, ProfileUserInfoState>(
            builder: (context, state) {
              return TileSettingItemWidget(
                title: "profile settings".tr(context),
                subTitle: "look at your profile settings".tr(context),
                onTap: () {
                  context.pushReplacementNamed(profileUserInfo);
                },
              );
            },
          ),
          TileSettingItemWidget(
            title: "logout".tr(context),
            subTitle: "refresh your login".tr(context),
            onTap: () async {
              sharedPreferences.setBool(isLogin, false);

              context.pushReplacementNamed(signInRoute);
            },
          ),
        ],
      ),
    );
  }
}
