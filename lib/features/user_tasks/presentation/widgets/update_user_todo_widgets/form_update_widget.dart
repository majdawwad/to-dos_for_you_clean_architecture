import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';
import '../../../domain/entities/user_todo.dart';
import '../../bloc/update_delete_user_todo/update_delete_user_todo_bloc.dart';
import 'form_submit_button_widget.dart';
import 'text_form_field_widget.dart';

class FormUpdateWidget extends StatefulWidget {
  final UserTodo userTodo;
  const FormUpdateWidget({
    super.key,
    required this.userTodo,
  });

  @override
  State<FormUpdateWidget> createState() => _FormUpdateWidgetState();
}

class _FormUpdateWidgetState extends State<FormUpdateWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  void initState() {
    _todoController.text = widget.userTodo.todo;
    _statusController.text = widget.userTodo.completed.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
              name: "todo".tr(context),
              multiLines: false,
              enabled: false,
              controller: _todoController,
            ),
            TextFormFieldWidget(
              name: "status".tr(context),
              multiLines: false,
              controller: _statusController,
            ),
            FormSubmitButtonWidget(
              onPressed: validateFormThenUpdateTodo,
            ),
          ],
        ),
      ),
    );
  }

  void validateFormThenUpdateTodo() {
    final bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      final UserTodo userTodo = UserTodo(
        id: widget.userTodo.id,
        todo: _todoController.text,
        completed: bool.parse(_statusController.text),
      );

      context
          .read<UpdateDeleteUserTodoBloc>()
          .add(UpdateUserTodoEvent(userTodo: userTodo));
    }
  }
}
