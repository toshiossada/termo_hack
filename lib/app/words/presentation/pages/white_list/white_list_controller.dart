import 'package:flutter/cupertino.dart';

import '../../../../commons/adapters/custom_alerts/dialog_adapter_interface.dart';
import '../../stores/words_store.dart';

class WhiteListController {
  final txtLetter = TextEditingController();
  final WordsStore wordStore;
  final IDialogAdapter dialog;

  WhiteListController({
    required this.wordStore,
    required this.dialog,
  });

  remove(String letter) => wordStore.removeWhiteList(letter);
  addLetter() {
    if (txtLetter.text.trim().isEmpty) return;
    if (wordStore.value.whiteList.any(
        (element) => element.toUpperCase() == txtLetter.text.toUpperCase())) {
      dialog.alertSnackBar('Letra ja esta na whitelist').show();
      txtLetter.clear();
      return;
    }
    if (txtLetter.text.isNotEmpty) {
      for (var e in txtLetter.text.runes) {
        var character = String.fromCharCode(e).toUpperCase().trim();
        if (character.isEmpty) return;
        if (wordStore.value.blackList.any((element) => element == character)) {
          dialog.alertSnackBar('Letra $character! ja esta na blackList');
          continue;
        }

        if (!wordStore.value.whiteList.any((element) =>
            element.toUpperCase() == txtLetter.text.toUpperCase())) {
          wordStore.addWhiteList(character);
        }
      }

      txtLetter.clear();
    }
  }
}
