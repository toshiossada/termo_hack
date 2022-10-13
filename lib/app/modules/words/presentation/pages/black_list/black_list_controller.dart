import 'package:flutter/cupertino.dart';

import '../../../../../commons/adapters/custom_alerts/dialog_adapter.dart';
import '../../../../../commons/extensions/match_letter_extension.dart';
import '../../stores/words_store.dart';

class BlackListController {
  final txtLetter = TextEditingController();
  final WordsStore wordStore;
  final IDialogAdapter dialog;
  final myFocusNode = FocusNode();

  BlackListController({
    required this.wordStore,
    required this.dialog,
  });
  remove(String letter) => wordStore.removeBlackList(letter.formatWord());

  addLetter() {
    if (txtLetter.text.trim().isEmpty) return;

    if (wordStore.value.blackList.any(
        (element) => element.formatWord() == txtLetter.text.formatWord())) {
      dialog.alertSnackBar('Letra ja esta na blacklist');
      txtLetter.clear();
      myFocusNode.requestFocus();
      return;
    }
    if (txtLetter.text.isNotEmpty) {
      for (var e in txtLetter.text.runes) {
        var character = String.fromCharCode(e).formatWord();
        if (character.isEmpty) return;
        if (!letterNotInWord(character)) {
          continue;
        }
        if (wordStore.value.whiteList.any((element) => element == character)) {
          continue;
        }
        if (wordStore.value.word.notPositionLetter
            .any((element) => element.letter == character)) {
          continue;
        }

        if (!wordStore.value.blackList.any(
            (element) => element.formatWord() == txtLetter.text.formatWord())) {
          wordStore.addBlackList(character);
        }
      }

      txtLetter.clear();
      myFocusNode.requestFocus();
    }
  }

  bool letterNotInWord(String letter) =>
      wordStore.value.word.firstLetter.formatWord() != letter.formatWord() &&
      wordStore.value.word.secondLetter.formatWord() != letter.formatWord() &&
      wordStore.value.word.thirdLetter.formatWord() != letter.formatWord() &&
      wordStore.value.word.fourthLetter.formatWord() != letter.formatWord() &&
      wordStore.value.word.fifthLetter.formatWord() != letter.formatWord();
}
