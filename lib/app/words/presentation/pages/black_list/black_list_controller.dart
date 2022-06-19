import 'package:flutter/cupertino.dart';

import '../../../../commons/adapters/custom_alerts/dialog_adapter_interface.dart';
import '../../stores/words_store.dart';

class BlackListController {
  final txtLetter = TextEditingController();
  final WordsStore wordStore;
  final IDialogAdapter dialog;

  BlackListController({
    required this.wordStore,
    required this.dialog,
  });

  remove(String letter) => wordStore.removeBlackList(letter);
  addLetter() {
    if (txtLetter.text.trim().isEmpty) return;

    if (wordStore.value.blackList.any(
        (element) => element.toUpperCase() == txtLetter.text.toUpperCase())) {
      dialog.alertSnackBar('Letra ja esta na blacklist');
      txtLetter.clear();
      return;
    }
    if (txtLetter.text.isNotEmpty) {
      for (var e in txtLetter.text.runes) {
        var character = String.fromCharCode(e).toUpperCase().trim();
        if (character.isEmpty) return;
        if (!letterNotInWord(character)) {
          dialog.alertSnackBar('Letra $character! ja esta na palavra');
          continue;
        }
        if (wordStore.value.whiteList.any((element) => element == character)) {
          dialog.alertSnackBar('Letra $character! ja esta na whitelist');
          continue;
        }

        if (!wordStore.value.blackList.any((element) =>
            element.toUpperCase() == txtLetter.text.toUpperCase())) {
          wordStore.addBlackList(character);
        }
      }

      txtLetter.clear();
    }
  }

  bool letterNotInWord(String letter) =>
      wordStore.value.word.firstLetter.toUpperCase() != letter.toUpperCase() &&
      wordStore.value.word.secondLetter.toUpperCase() != letter.toUpperCase() &&
      wordStore.value.word.thirdLetter.toUpperCase() != letter.toUpperCase() &&
      wordStore.value.word.fourthLetter.toUpperCase() != letter.toUpperCase() &&
      wordStore.value.word.fifthLetter.toUpperCase() != letter.toUpperCase();
}
