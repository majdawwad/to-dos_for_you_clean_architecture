import 'package:flutter/material.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';
import '../todo_details_widgets/edit_or_delete_button_widget.dart';

class FormSubmitButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  const FormSubmitButtonWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return EditOrDeleteButtonWidget(
      onPressed: onPressed,
      isColorRedAccent: false,
      iconData: Icons.edit,
      btnText: "Update".tr(context),
    );
  }
}
