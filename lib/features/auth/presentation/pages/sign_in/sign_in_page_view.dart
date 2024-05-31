import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:maidscc_todos_app/core/app_theme/app_theme.dart';
import 'package:maidscc_todos_app/features/settings/presentation/bloc/profile_user_info/profile_user_info_bloc.dart';

import '../../../../../core/app_theme/app_text_style.dart';
import '../../../../../core/app_theme/bloc/theme_bloc.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/extentions/media_query.dart';
import '../../../../../core/route/router_name.dart';
import '../../../../../core/util/snackbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../core/widgets/text_form_field_widget.dart';
import '../../../../../dependency_injection.dart' as di;
import '../../../domain/entities/user.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../widgets/custom_button_widget.dart';

class SignInPageView extends StatefulWidget {
  const SignInPageView({super.key});

  @override
  State<SignInPageView> createState() => _SignInPageViewState();
}

class _SignInPageViewState extends State<SignInPageView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _userPasswordController = TextEditingController();

  final TextEditingController _userExpiresInMinsController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => di.sl<AuthBloc>(),
      child: Scaffold(
        body: _buildBoby(context: context),
      ),
    );
  }

  Widget _buildBoby({
    required BuildContext context,
  }) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthIsLoadedState) {
          SnackBarMessage.snackBarSuccessMessage(
            context: context,
            message: state.message,
          );

          context.pushReplacementNamed(layoutRoute);
        } else if (state is AuthIsErrorState) {
          SnackBarMessage.snackBarErrorMessage(
            context: context,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, stateTheme) {
            bool swtVal = false;
            if (stateTheme is ThemeInitial) {
              swtVal = stateTheme.switchVal;
            } else if (stateTheme is LoadedThemeState) {
              swtVal = stateTheme.switchVal;
            }
            return SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                        maxHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppPadding.paddingTwenty.h,
                          horizontal: AppPadding.paddingTwenty.w,
                        ),
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: AppPadding.paddingTwenty.h,
                                    left: AppPadding.paddingTwenty.w,
                                  ),
                                  child: Text(
                                    "welcome".tr(context),
                                    style: AppTextStyle.textStyle1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: AppPadding.paddingTwenty.w,
                                  ),
                                  child: Text(
                                    "enter_data".tr(context),
                                    style: AppTextStyle.textStyle2.copyWith(
                                      color: swtVal ? white : grey,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: AppPadding.paddingThirty.h,
                                      left: AppPadding.paddingTwenty.w,
                                      right: AppPadding.paddingTwenty.w),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom:
                                                  AppPadding.paddingTwenty.h),
                                          child: Text(
                                            'user name'.tr(context),
                                            style: AppTextStyle.textStyle3
                                                .copyWith(
                                              color: swtVal ? white : black,
                                            ),
                                          ),
                                        ),
                                        TextFormFieldWidget(
                                          textEditingController:
                                              _userNameController,
                                          hintText: 'enter your user name'
                                              .tr(context),
                                          iconDataPrefix: Icons.person_3_sharp,
                                          keyboardType: TextInputType.name,
                                          validation: (value) {
                                            if (value!.isEmpty) {
                                              return "you must to enter your user name"
                                                  .tr(context);
                                            } else if (value.isNotEmpty &&
                                                value.length < 5) {
                                              return "the name must not to be smaller than five charcters"
                                                  .tr(context);
                                            }
                                            return null;
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom:
                                                  AppPadding.paddingTwenty.h,
                                              top: AppPadding.paddingTwenty.h),
                                          child: Text(
                                            'password'.tr(context),
                                            style: AppTextStyle.textStyle3
                                                .copyWith(
                                              color: swtVal ? white : black,
                                            ),
                                          ),
                                        ),
                                        BlocBuilder<AuthBloc, AuthState>(
                                          builder: (context, state) {
                                            bool obsec = true;
                                            if (state is AuthInitial) {
                                              obsec = state.obscureText;
                                            } else if (state
                                                is AuthObsecureTextState) {
                                              obsec = state.obscureText;
                                            }
                                            return TextFormFieldWidget(
                                              textEditingController:
                                                  _userPasswordController,
                                              hintText: 'enter your password'
                                                  .tr(context),
                                              iconDataPrefix: Icons.lock,
                                              obscureText: obsec,
                                              iconDataSuffix: obsec
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              onTapSuffix: () {
                                                context.read<AuthBloc>().add(
                                                      AuthToggleObscureTextEvent(
                                                        obscureText: obsec,
                                                      ),
                                                    );
                                              },
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              validation: (value) {
                                                if (value!.isEmpty) {
                                                  return 'you must to enter your password'
                                                      .tr(context);
                                                } else {
                                                  if (value.length < 8) {
                                                    return "the password must not to be smaller than eight numbers"
                                                        .tr(context);
                                                  } else {
                                                    return null;
                                                  }
                                                }
                                              },
                                            );
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom:
                                                  AppPadding.paddingTwenty.h,
                                              top: AppPadding.paddingTwenty.h),
                                          child: Text(
                                            'user expiresIn mins'.tr(context),
                                            style: AppTextStyle.textStyle3
                                                .copyWith(
                                              color: swtVal ? white : black,
                                            ),
                                          ),
                                        ),
                                        TextFormFieldWidget(
                                          textEditingController:
                                              _userExpiresInMinsController,
                                          hintText: 'enter your expiresIn mins'
                                              .tr(context),
                                          iconDataPrefix: Icons.person_3_sharp,
                                          keyboardType: TextInputType.number,
                                          validation: (value) {
                                            if (value!.isNotEmpty &&
                                                int.parse(value) > 60) {
                                              return "the expiresIn mins must to be smaller than 60"
                                                  .tr(context);
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: context.screenHeight / 4.5),
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    if (state is AuthIsLoadingState) {
                                      return const LoadingWidget();
                                    }
                                    return CustomButtonWidget(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          User user = User(
                                            username:
                                                _userNameController.text.trim(),
                                            password: _userPasswordController
                                                .text
                                                .trim(),
                                            expiresInMins:
                                                _userExpiresInMinsController
                                                        .text.isNotEmpty
                                                    ? int.parse(
                                                        _userExpiresInMinsController
                                                            .text
                                                            .trim())
                                                    : int.parse("60"),
                                          );

                                          context.read<AuthBloc>().add(
                                              AuthSignInEvent(userData: user));
                                          context
                                              .read<ProfileUserInfoBloc>()
                                              .add(
                                                  GetAllProfileUserInfoEvent());
                                        }
                                      },
                                      textButton: "login".tr(context),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
