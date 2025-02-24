import 'package:flutter/material.dart';

import '../../../../../../commons/extensions/key_extension.dart';

class ActionWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final int? count;
  final Color color;
  final double? paddingLeft;
  final IconData icon;

  const ActionWidget({
    Key? key,
    required this.onPressed,
    required this.count,
    required this.color,
    required this.icon,
    this.paddingLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingLeft ?? 0, vertical: 8),
      child: Badge(
        backgroundColor: color,
        label: Text(
          count.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        child: Semantics(
          identifier: super.key?.keyValue,
          label: count.toString(),
          child: IconButton(
            icon: Icon(
              icon,
              color: color,
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
