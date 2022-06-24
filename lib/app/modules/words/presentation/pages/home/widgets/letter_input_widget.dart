import 'package:flutter/material.dart';

class LetterInputWidget extends StatelessWidget {
  final Function(String?)? onChanged;
  final TextEditingController controller;
  final TextInputAction? inputAction;

  const LetterInputWidget({
    super.key,
    this.onChanged,
    required this.controller,
    this.inputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          maxLength: 1,
          onChanged: (v) {
            if (onChanged != null) onChanged!(v);
            FocusScope.of(context).nextFocus();
          },
          textInputAction: inputAction ?? TextInputAction.next,
          decoration: const InputDecoration(
            counterText: '',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
