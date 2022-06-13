import 'package:diacritic/diacritic.dart';

extension MatchLetterExtension on String {
  bool matchLetter({
    required String letter,
    required int position,
  }) {
    return letter.isEmpty ||
        removeDiacritics(substring(position - 1, position).toUpperCase()) ==
            letter.toUpperCase();
  }

  bool blackListLetter(List<String> blacklist) =>
      blacklist.isEmpty ||
      blacklist
          .where((element) =>
              element.isNotEmpty &&
              removeDiacritics(toUpperCase())
                  .contains(removeDiacritics(element.toUpperCase())))
          .toList()
          .isEmpty;

  bool whiteListLetter(List<String> whiteList) {
    if (whiteList.isEmpty) return true;
    var result = true;
    for (var element in whiteList) {
      if (!removeDiacritics(toUpperCase())
          .contains(removeDiacritics(element))) {
        if (length < 5 && element == 'S') continue;
        result = false;
        break;
      }
    }
    return result;
  }
}
