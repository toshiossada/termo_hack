import 'package:flutter/material.dart';

import '../../../../../../commons/extensions/key_extension.dart';

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
        child: Semantics(
          identifier: key?.keyValue,
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
      ),
    );
  }
}
