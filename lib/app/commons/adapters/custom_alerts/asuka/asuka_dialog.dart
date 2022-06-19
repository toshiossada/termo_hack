import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

import '../dialog_adapter_interface.dart';

class AsukaDialog implements IDialogAdapter {
  @override
  showDialog(Widget child) {
    asuka.showDialog(builder: (context) => child);
  }

  @override
  alertSnackBar(String text) {
    asuka.AsukaSnackbar.alert(text).show();
  }
}
