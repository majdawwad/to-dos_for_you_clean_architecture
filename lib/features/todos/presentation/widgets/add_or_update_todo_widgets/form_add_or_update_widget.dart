import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maidscc_todos_app/core/extentions/media_query.dart';

import '../../../domain/entities/todo.dart';
import '../../bloc/add_update_delete_todo/add_update_delete_todo_bloc.dart';
import 'form_submit_button_widget.dart';
import 'text_form_field_widget.dart';

class FormAddOrUpdateWidget extends StatefulWidget {
  final Todo? todo;
  final bool isUpdateTodo;
  const FormAddOrUpdateWidget({
    super.key,
    this.todo,
    required this.isUpdateTodo,
  });

  @override
  State<FormAddOrUpdateWidget> createState() => _FormAddOrUpdateWidgetState();
}

class _FormAddOrUpdateWidgetState extends State<FormAddOrUpdateWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdateTodo) {
      _todoController.text = widget.todo!.todo;
      _statusController.text = widget.todo!.completed.toString();
    }
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
              enabled: widget.isUpdateTodo ? false : true,
              controller: _todoController,
            ),
            if (widget.isUpdateTodo)
              TextFormFieldWidget(
                name: "status".tr(context),
                multiLines: false,
                controller: _statusController,
              ),
            FormSubmitButtonWidget(
              isUpdateTodo: widget.isUpdateTodo,
              onPressed: validateFormThenAddOrUpdateTodo,
            ),
          ],
        ),
      ),
    );
  }

  void validateFormThenAddOrUpdateTodo() {
    final bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      final Todo todo = Todo(
        id: widget.isUpdateTodo ? widget.todo!.id : null,
        todo: _todoController.text,
        completed:
            widget.isUpdateTodo ? bool.parse(_statusController.text) : false,
      );
      if (widget.isUpdateTodo) {
        context
            .read<AddUpdateDeleteTodoBloc>()
            .add(UpdateTodoEvent(todo: todo));
      } else {
        context.read<AddUpdateDeleteTodoBloc>().add(AddTodoEvent(todo: todo));
      }
    }
  }
}
