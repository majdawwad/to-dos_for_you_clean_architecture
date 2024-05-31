import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:maidscc_todos_app/core/app_theme/theme_cache_helper.dart';

import '../../../../core/app_theme/app_text_style.dart';
import '../../../../core/app_theme/app_theme.dart';
import '../../../../core/constants/app_assets_route.dart';
import '../../../../core/extentions/media_query.dart';

class SplashPageView extends StatefulWidget {
  const SplashPageView({super.key});

  @override
  SplashPageViewState createState() => SplashPageViewState();
}

class SplashPageViewState extends State<SplashPageView> {
  bool _a = false;
  late Timer _timer;
  late int themeIndex = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 700), () {
      if (mounted) {
        setState(() {
          _a = !_a;
        });
      }
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    themeIndex = await ThemeCacheHelper().getCachedThemeIndex();

    _timer = Timer(const Duration(milliseconds: 2000), () {
      if (mounted) {
        setState(() {
          context.go(Uri(path: "/sign-in-page").toString());
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.fastLinearToSlowEaseIn,
            width: _a ? context.screenWidth : 0.w,
            height: context.screenHeight,
            color: themeIndex == 1 ? blackDeep : white,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssetsRoute.logo,
                  height: 75.h,
                  width: 75.w,
                  filterQuality: FilterQuality.high,
                ),
                SizedBox(height: 20.h),
                Text(
                  "TODOS APP",
                  style: AppTextStyle.textStyle1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
