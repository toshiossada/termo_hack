import 'package:flutter/widgets.dart';

abstract class IDialogAdapter {
  void showDialog(Widget child);
  void alertSnackBar(String text);
}
