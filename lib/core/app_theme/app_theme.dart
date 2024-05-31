import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constants.dart';
import 'app_text_style.dart';

const primaryColor = Color.fromARGB(255, 255, 77, 0);
const foregroundColor = Color(0xffF5F5F5);
const grey = Color(0xffB1B1B1);
const lightGrey2 = Color(0xffC7C7C7);
const blue = Color(0xff0978F2);
const red = Color(0xffFF5757);
const black = Color(0xff333333);
const blackDeep = Colors.black;
const lightGrey1 = Color(0xffF3F4F6);
const white = Color(0xffFFFFFF);
const green = Color.fromARGB(255, 69, 184, 58);
const yellow = Colors.yellow;

enum AppTheme {
  light("Light"),
  dark("Dark");

  final String name;
  const AppTheme(this.name);
}

final appThemeData = {
  AppTheme.light: ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0.0.h,
      backgroundColor: primaryColor,
      titleTextStyle: AppTextStyle.textStyle1.copyWith(
        fontWeight: fontWeightw700,
        color: white,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: white,
    ),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
    ),
    fontFamily: "Montserrat",
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: primaryColor),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(primaryColor),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: AppFontSize.fontSizeSixteen.sp,
            color: white,
          ),
        ),
        animationDuration: const Duration(seconds: 3),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: black),
      floatingLabelStyle: const TextStyle(color: black),
      hintStyle: const TextStyle(color: lightGrey2),
      suffixIconColor: primaryColor,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: foregroundColor),
        borderRadius: BorderRadius.circular(defaultRadius.r),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: foregroundColor),
        borderRadius: BorderRadius.circular(defaultRadius.r),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      elevation: 0.0.h,
      selectedItemColor: white,
      showSelectedLabels: true,
      selectedLabelStyle: AppTextStyle.textStyle1.copyWith(
        color: white,
        fontSize: AppFontSize.fontSizeTwelve,
      ),
      unselectedItemColor: grey,
      unselectedLabelStyle: AppTextStyle.textStyle1.copyWith(
        color: grey,
        fontSize: AppFontSize.fontSizeTwelve,
      ),
    ),
  ),
  AppTheme.dark: ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0.0.h,
      backgroundColor: primaryColor,
      titleTextStyle: AppTextStyle.textStyle1.copyWith(
        fontWeight: fontWeightw700,
        color: white,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: black,
    ),
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
    ),
    fontFamily: "Montserrat",
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: primaryColor),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(primaryColor),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: AppFontSize.fontSizeSixteen.sp,
            color: white,
          ),
        ),
        animationDuration: const Duration(seconds: 3),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: white),
      floatingLabelStyle: const TextStyle(color: white),
      hintStyle: const TextStyle(color: white),
      suffixIconColor: primaryColor,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: foregroundColor),
        borderRadius: BorderRadius.circular(defaultRadius.r),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: foregroundColor),
        borderRadius: BorderRadius.circular(defaultRadius.r),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      elevation: 0.0.h,
      selectedItemColor: white,
      showSelectedLabels: true,
      selectedLabelStyle: AppTextStyle.textStyle1.copyWith(
        color: white,
        fontSize: AppFontSize.fontSizeTwelve,
      ),
      unselectedItemColor: grey,
      unselectedLabelStyle: AppTextStyle.textStyle1.copyWith(
        color: grey,
        fontSize: AppFontSize.fontSizeTwelve,
      ),
    ),
  ),
};
