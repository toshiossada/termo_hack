import 'package:flutter/cupertino.dart';

import 'package:asuka/asuka.dart' as asuka;
import '../../stores/words_store.dart';

class WhiteListController {
  final txtLetter = TextEditingController();
  final WordsStore wordStore;

  WhiteListController({
    required this.wordStore,
  });

  remove(String letter) => wordStore.removeWhiteList(letter);
  addLetter() {
    if (wordStore.value.whiteList.any(
        (element) => element.toUpperCase() == txtLetter.text.toUpperCase())) {
      asuka.AsukaSnackbar.alert('Letra ja esta na whitelist').show();
      txtLetter.clear();
      return;
    }
    if (txtLetter.text.isNotEmpty) {
      for (var e in txtLetter.text.runes) {
        var character = String.fromCharCode(e).toUpperCase();
        if (wordStore.value.blackList.any((element) => element == character)) {
          asuka.AsukaSnackbar.alert('Letra $character! ja esta na blackList').show();
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
