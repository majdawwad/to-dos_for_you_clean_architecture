import 'package:flutter/material.dart';
import '../../../../../core/app_theme/app_text_style.dart';

import '../../../../../core/app_theme/app_theme.dart';

class EditOrDeleteButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final bool isColorRedAccent;
  final IconData iconData;
  final String btnText;
  const EditOrDeleteButtonWidget({
    super.key,
    required this.onPressed,
    required this.isColorRedAccent,
    required this.iconData,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          isColorRedAccent ? Colors.redAccent : primaryColor,
        ),
      ),
      icon: Icon(
        iconData,
        color: white,
      ),
      label: Text(
        btnText,
        style: AppTextStyle.textStyle4.copyWith(fontWeight: fontWeightw700),
      ),
    );
  }
}
