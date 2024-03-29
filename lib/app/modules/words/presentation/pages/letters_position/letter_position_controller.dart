import 'package:flutter/cupertino.dart';

import '../../../../../commons/extensions/match_letter_extension.dart';
import '../../stores/words_store.dart';
import 'letter_position_store.dart';

class LetterPositionController {
  final WordsStore wordStore;
  final LetterPositionStore letterPositionStore;

  final txtLetter = TextEditingController();
  final myFocusNode = FocusNode();
  int get dropdownValue => letterPositionStore.value;
  set dropdownValue(int i) => letterPositionStore.value = i;

  LetterPositionController({
    required this.wordStore,
    required this.letterPositionStore,
  });

  remove(String letter, int position) =>
      wordStore.removeNotPositionLetter(letter, position);

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
