import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maidscc_todos_app/core/constants/constants.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool multiLines;
  final String name;
  final bool? enabled;
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.multiLines,
    required this.name,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.paddingTen.w,
        vertical: AppPadding.paddingTen.h,
      ),
      child: TextFormField(
        controller: controller,
        enabled: enabled ?? true,
        validator: (value) {
          if (value!.isEmpty) {
            return "You must to fill the $name's field";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: name,
        ),
        maxLines: multiLines ? 6 : 1,
        minLines: multiLines ? 6 : 1,
      ),
    );
  }
}
