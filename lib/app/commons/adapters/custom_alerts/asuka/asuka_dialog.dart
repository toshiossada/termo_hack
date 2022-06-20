import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

import '../dialog_adapter.dart';

class AsukaDialog implements IDialogAdapter {
  @override
  void showDialog(Widget child) {
    asuka.showDialog(builder: (context) => child);
  }

  @override
  void alertSnackBar(String text) {
    asuka.AsukaSnackbar.alert(text).show();
  }
}
