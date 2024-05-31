import 'package:flutter/material.dart';

import '../../../../core/app_theme/app_text_style.dart';
import '../../../../core/app_theme/app_theme.dart';

class ProfileItemInfoWidget extends StatelessWidget {
  final String title;
  final String description;

  const ProfileItemInfoWidget({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.textStyle2.copyWith(
            fontWeight: fontWeightw800,
            color: grey,
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: AppTextStyle.textStyle2.copyWith(
              fontWeight: fontWeightw800,
              color: white,
            ),
          ),
        ),
      ],
    );
  }
}
