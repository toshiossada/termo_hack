import 'dart:convert';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

extension MatchLetterExt on String {
  bool matchLetter({
    required String letter,
    required int position,
  }) {
    return letter.isEmpty ||
        removeDiacritics(substring(position - 1, position).toUpperCase()) ==
            letter.toUpperCase();
  }

  bool blackListLetter(List<String> blacklist) => blacklist
      .where((element) =>
          element.isNotEmpty &&
          removeDiacritics(toUpperCase())
              .contains(removeDiacritics(element.toUpperCase())))
      .toList()
      .isEmpty;
  bool whiteListLetter(List<String> whiteList) => whiteList
      .where((element) =>
          element.isNotEmpty &&
          removeDiacritics(toUpperCase())
              .contains(removeDiacritics(element.toUpperCase())))
      .toList()
      .isNotEmpty;
}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });
  test('Counter increments smoke test', () async {
    final String response = await rootBundle.loadString('assets/words.json');
    final data = await json.decode(response);
    final words = (data['words'] as List).map((e) => e.toString()).toList();

    const first = 's', second = '', third = '', forth = 'i', fifth = 'o';

    final blackLetters = <String>['a', 'e', 'r', 'd', 'p', 'u', 't'];
    final whiteLetters = <String>['i'];

    blackLetters
        .where((element) =>
            element.isNotEmpty &&
            'êxito'
                .toUpperCase()
                .contains(removeDiacritics(element.toUpperCase())))
        .toList()
        .isEmpty;

    final result = words
        .where((element) =>
            element.length == 5 &&
            element.whiteListLetter(whiteLetters) &&
            element.blackListLetter(blackLetters) &&
            element.matchLetter(letter: first, position: 1) &&
            element.matchLetter(letter: second, position: 2) &&
            element.matchLetter(letter: third, position: 3) &&
            element.matchLetter(letter: forth, position: 4) &&
            element.matchLetter(letter: fifth, position: 5))
        .toList();
  });
}
