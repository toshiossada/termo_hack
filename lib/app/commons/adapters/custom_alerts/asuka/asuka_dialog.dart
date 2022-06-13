import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

import '../dialog_adapter.dart';

class AsukaDialog implements DialogAdapter {
  @override
  showDialog(Widget child) {
    asuka.showDialog(builder: (context) => child);
  }
}
