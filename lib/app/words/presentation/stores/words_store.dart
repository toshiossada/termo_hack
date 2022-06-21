import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';

import '../../../commons/extensions/match_letter_extension.dart';
import '../viewmodels/words_view_model.dart';

class WordsStore extends ValueNotifier<WordsViewModel> {
  WordsStore() : super(WordsViewModel());

  clear() => value = WordsViewModel();
  setLoad({bool load = false}) => value = value.copyWith(loading: load);

  loadWords(List<String> newWords) => value = value.copyWith(words: newWords);

  addBlackList(String letter) {
    final formatLetter = letter.formatWord();
    var list = List<String>.from(value.blackList);
    if (list.any((element) => element.toUpperCase() == formatLetter)) {
      list.remove(formatLetter);
    }
    list.add(removeDiacritics(letter.toUpperCase()));

    value = value.copyWith(blackList: list);
  }

  removeBlackList(String letter) {
    var list = List<String>.from(value.blackList);
    list.remove(removeDiacritics(letter.toUpperCase()));

    value = value.copyWith(blackList: list);
  }

  addWhiteList(String letter) {
    final l = removeDiacritics(letter.toUpperCase());
    var list = List<String>.from(value.whiteList);
    if (list.any((element) => element.toUpperCase() == l)) {
      list.remove(l);
    }
    list.add(removeDiacritics(letter.toUpperCase()));

    value = value.copyWith(whiteList: list);
  }

  removeWhiteList(String letter) {
    var list = List<String>.from(value.whiteList);
    list.remove(removeDiacritics(letter.toUpperCase()));

    value = value.copyWith(whiteList: list);
  }

  changeLetter(String letter, int position) {
    var word = value.word;
    switch (position) {
      case 1:
        word = word.copyWith(firstLetter: letter);
        break;
      case 2:
        word = word.copyWith(secondLetter: letter);
        break;
      case 3:
        word = word.copyWith(thirdLetter: letter);
        break;
      case 4:
        word = word.copyWith(fourthLetter: letter);
        break;
      case 5:
        word = word.copyWith(fifthLetter: letter);
        break;
      default:
    }

    value = value.copyWith(word: word);
  }
}
