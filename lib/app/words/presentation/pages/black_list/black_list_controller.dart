import 'package:flutter/cupertino.dart';

import 'package:asuka/asuka.dart' as asuka;
import '../../stores/words_store.dart';

class BlackListController {
  final txtLetter = TextEditingController();
  final WordsStore wordStore;

  BlackListController({
    required this.wordStore,
  });

  remove(String letter) => wordStore.removeBlackList(letter);
  addLetter() {
    if (wordStore.value.blackList.any(
        (element) => element.toUpperCase() == txtLetter.text.toUpperCase())) {
      asuka.AsukaSnackbar.alert('Letra ja esta na blacklist').show();
      txtLetter.clear();
      return;
    }
    if (txtLetter.text.isNotEmpty) {
      for (var e in txtLetter.text.runes) {
        var character = String.fromCharCode(e).toUpperCase();
        if (!letterNotInWord(character)) {
          asuka.AsukaSnackbar.alert('Letra $character! ja esta na palavra')
              .show();
          continue;
        }
        if (wordStore.value.whiteList.any((element) => element == character)) {
          asuka.AsukaSnackbar.alert('Letra $character! ja esta na whitelist')
              .show();
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
