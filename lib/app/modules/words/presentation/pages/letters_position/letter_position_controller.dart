import 'package:flutter/cupertino.dart';

import '../../../../../commons/extensions/match_letter_extension.dart';
import '../../stores/words_store.dart';

class LetterPositionController {
  final txtLetter = TextEditingController();
  final WordsStore wordStore;
  final myFocusNode = FocusNode();
  int dropdownValue = 1;

  LetterPositionController({
    required this.wordStore,
  });

  remove(String letter, int position) =>
      wordStore.removeNotPositionLetter(txtLetter.text, position);

  addLetter() {
    if (txtLetter.text.trim().isEmpty) return;

    if (txtLetter.text.isNotEmpty) {
      wordStore.addPosition(txtLetter.text, dropdownValue);
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
