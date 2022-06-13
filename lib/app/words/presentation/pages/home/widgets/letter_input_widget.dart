import 'package:flutter/material.dart';

class LetterInputWidget extends StatelessWidget {
  final Function(String?)? onChanged;
  final TextEditingController controller;

  const LetterInputWidget({
    Key? key,
    this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          maxLength: 1,
          onChanged: onChanged,
          decoration: const InputDecoration(
            counterText: '',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
