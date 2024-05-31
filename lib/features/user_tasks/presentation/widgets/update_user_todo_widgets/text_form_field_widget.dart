import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
