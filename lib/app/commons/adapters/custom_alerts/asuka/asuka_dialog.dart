import 'package:flutter/material.dart';

import '../dialog_adapter.dart';

typedef ShowDialog = void Function(Widget);
typedef Alert = void Function(String);

class AsukaDialog implements IDialogAdapter {
  final ShowDialog fShowDialog;
  final Alert fAlert;

  AsukaDialog({
    required this.fShowDialog,
    required this.fAlert,
  });

  @override
  void showDialog(Widget child) {
    fShowDialog(child);
  }

  @override
  void alertSnackBar(String text) {
    fAlert(text);
  }
}
