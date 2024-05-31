import 'package:flutter/material.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';

import '../todo_details_widgets/edit_or_delete_button_widget.dart';

class FormSubmitButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdateTodo;
  const FormSubmitButtonWidget({
    super.key,
    required this.onPressed,
    required this.isUpdateTodo,
  });

  @override
  Widget build(BuildContext context) {
    return EditOrDeleteButtonWidget(
      onPressed: onPressed,
      isColorRedAccent: false,
      iconData: isUpdateTodo ? Icons.edit : Icons.add,
      btnText: isUpdateTodo ? "Update".tr(context) : "Add".tr(context),
    );
  }
}
