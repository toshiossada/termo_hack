import 'package:flutter/widgets.dart';

abstract class IDialogAdapter {
  showDialog(Widget child);
  alertSnackBar(String text);
}
