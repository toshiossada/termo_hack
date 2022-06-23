import 'package:flutter/material.dart';

import '../dialog_adapter.dart';

typedef FShowDialog = void Function(Widget);
typedef FAlert = void Function(String);

class AsukaDialog implements IDialogAdapter {
  final FShowDialog fShowDialog;
  final FAlert fAlert;

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
