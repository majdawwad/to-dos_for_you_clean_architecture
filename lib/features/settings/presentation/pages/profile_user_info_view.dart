import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:maidscc_todos_app/core/app_theme/app_theme.dart';
import 'package:maidscc_todos_app/core/constants/constants.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';
import 'package:maidscc_todos_app/core/route/router_name.dart';
import 'package:maidscc_todos_app/core/widgets/loading_widget.dart';
import 'package:maidscc_todos_app/features/settings/presentation/bloc/profile_user_info/profile_user_info_bloc.dart';
import 'package:maidscc_todos_app/features/todos/presentation/widgets/todos_page_widgets/message_display_widget.dart';

import '../widgets/profile_image_and_name_item_widget.dart';
import '../widgets/profile_item_info_widget.dart';

class ProfileUserInfoView extends StatefulWidget {
  const ProfileUserInfoView({super.key});

  @override
  State<ProfileUserInfoView> createState() => _ProfileUserInfoViewState();
}

class _ProfileUserInfoViewState extends State<ProfileUserInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.pushReplacementNamed(layoutRoute);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: white,
        ),
      ),
      title: Text(
        "Your Profile".tr(context),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ProfileUserInfoBloc, ProfileUserInfoState>(
      builder: (context, state) {
        if (state is LoadingProfileUserState) {
          return const LoadingWidget();
        } else if (state is LoadedProfileUserInfoState) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.paddingTwenty.w,
              vertical: AppPadding.paddingTwenty.h,
            ),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Card(
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(defaultRadius.r)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.paddingTwenty.w,
                      vertical: AppPadding.paddingTwenty.h,
                    ),
                    child: ProfileImageAndNameItemWidget(
                      decorationColor: white,
                      imageRoute: state.profileUser.image,
                      borderColor: primaryColor,
                      nameColor: white,
                      fLname:
                          "${state.profileUser.firstName} ${state.profileUser.lastName}",
                      userName: state.profileUser.userName,
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
                SizedBox(height: 20.0.h),
                Card(
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(defaultRadius.r)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.paddingTwenty.w,
                      vertical: AppPadding.paddingTwenty.h,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ProfileItemInfoWidget(
                            title: 'Maiden Name: '.tr(context),
                            description: state.profileUser.maidenName,
                          ),
                          const DividerProfileUserInfoWidget(),
                          ProfileItemInfoWidget(
                            title: 'E-mail: '.tr(context),
                            description: state.profileUser.email,
                          ),
                          const DividerProfileUserInfoWidget(),
                          ProfileItemInfoWidget(
                            title: 'Phone: '.tr(context),
                            description: state.profileUser.phone,
                          ),
                          const DividerProfileUserInfoWidget(),
                          ProfileItemInfoWidget(
                            title: 'birth Date: '.tr(context),
                            description: state.profileUser.birthDate,
                          ),
                          const DividerProfileUserInfoWidget(),
                          ProfileItemInfoWidget(
                            title: 'Gender: '.tr(context),
                            description: state.profileUser.gender,
                          ),
                          const DividerProfileUserInfoWidget(),
                          ProfileItemInfoWidget(
                            title: 'Age: '.tr(context),
                            description: '${state.profileUser.age}',
                          ),
                          const DividerProfileUserInfoWidget(),
                          ProfileItemInfoWidget(
                            title: 'Eye Color: '.tr(context),
                            description: state.profileUser.eyeColor,
                          ),
                          const DividerProfileUserInfoWidget(),
                          ProfileItemInfoWidget(
                            title: 'Blood Group: '.tr(context),
                            description: state.profileUser.bloodGroup,
                          ),
                          const DividerProfileUserInfoWidget(),
                          ProfileItemInfoWidget(
                            title: 'Hair: '.tr(context),
                            description:
                                '${state.profileUser.hair.color}, ${state.profileUser.hair.type}',
                          ),
                          const DividerProfileUserInfoWidget(),
                          ProfileItemInfoWidget(
                            title: 'Height: '.tr(context),
                            description: '${state.profileUser.height}',
                          ),
                          const DividerProfileUserInfoWidget(),
                          ProfileItemInfoWidget(
                            title: 'Weight: '.tr(context),
                            description: '${state.profileUser.weight}',
                          ),
                          const DividerProfileUserInfoWidget(),
                          ProfileItemInfoWidget(
                            title: 'Role: '.tr(context),
                            description: state.profileUser.role,
                          ),
                          const DividerProfileUserInfoWidget(),
                          ProfileItemInfoWidget(
                            title: 'University: '.tr(context),
                            description: state.profileUser.university,
                          ),
                          const DividerProfileUserInfoWidget(),
                          ProfileItemInfoWidget(
                            title: 'Address: '.tr(context),
                            description:
                                '${state.profileUser.address.address}, ${state.profileUser.address.state}, ${state.profileUser.address.city}, ${state.profileUser.address.country}, ${state.profileUser.address.stateCode}, ${state.profileUser.address.postalCode}',
                          ),
                          const DividerProfileUserInfoWidget(),
                          ProfileItemInfoWidget(
                            title: 'Company: '.tr(context),
                            description:
                                '${state.profileUser.company.department}, ${state.profileUser.company.name}, ${state.profileUser.company.title}',
                          ),
                          ProfileItemInfoWidget(
                            title: 'Address Company: '.tr(context),
                            description:
                                '${state.profileUser.company.address.address}, ${state.profileUser.company.address.state}, ${state.profileUser.company.address.city}, ${state.profileUser.company.address.country}, ${state.profileUser.company.address.stateCode}, ${state.profileUser.company.address.postalCode}',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is ErrorProfileUserInfoState) {
          return MessageDisplayWidget(message: state.message);
        }
        return const SizedBox();
      },
    );
  }
}

class DividerProfileUserInfoWidget extends StatelessWidget {
  const DividerProfileUserInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppPadding.paddingTen.h,
        bottom: AppPadding.paddingTen.h,
      ),
      child: Divider(
        color: white,
        height: 2.0.h,
      ),
    );
  }
}
