import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

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
        badgeColor: color,
        badgeContent: Text(
          count.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        child: IconButton(
          icon: Icon(
            icon,
            color: color,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
