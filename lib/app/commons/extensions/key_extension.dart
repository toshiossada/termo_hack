import 'package:flutter/material.dart';

extension KeyExtension on Key {
  String get keyValue {
    if (this is ValueKey) {
      return (this as ValueKey).value.toString();
    }
    if (this is GlobalKey) {
      return toString().split(' ').last.replaceAll(RegExp(r"[\[\]<>']"), '');
    } else {
      return toString().replaceAll(RegExp(r"[\[\]<>']"), '');
    }
  }
}
