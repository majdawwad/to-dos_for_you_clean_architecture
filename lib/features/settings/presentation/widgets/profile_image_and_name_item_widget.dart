import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_theme/app_text_style.dart';

class ProfileImageAndNameItemWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color decorationColor;
  final String imageRoute;
  final Color borderColor;
  final Color nameColor;
  final String fLname;
  final String userName;

  const ProfileImageAndNameItemWidget({
    super.key,
    required this.decorationColor,
    required this.imageRoute,
    required this.borderColor,
    required this.nameColor,
    required this.fLname,
    required this.userName,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: width.w,
          height: height.h,
          decoration: BoxDecoration(
            color: decorationColor,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(imageRoute),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              color: borderColor,
              width: 2.0.w,
            ),
          ),
        ),
        SizedBox(width: 10.0.h),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                fLname,
                style: AppTextStyle.textStyle1.copyWith(
                  fontWeight: fontWeightw800,
                  color: nameColor,
                ),
              ),
              Text(
                userName,
                style: AppTextStyle.textStyle2.copyWith(
                  fontWeight: fontWeightw800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
