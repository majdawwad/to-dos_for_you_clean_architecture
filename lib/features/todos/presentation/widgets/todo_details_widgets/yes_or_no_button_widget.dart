import 'package:flutter/material.dart';

import '../../../../../core/app_theme/app_text_style.dart';

class YesOrNoButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final String btnText;
  final Color color;
  const YesOrNoButtonWidget({
    super.key,
    required this.onPressed,
    required this.btnText,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        btnText,
        style: AppTextStyle.textStyle4.copyWith(
          fontWeight: fontWeightw700,
          color: color,
        ),
      ),
    );
  }
}
