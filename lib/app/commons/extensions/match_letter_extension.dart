import 'package:diacritic/diacritic.dart';

extension MatchLetterExtension on String {
  String formatWord() => removeDiacritics(toUpperCase()).trim();

  bool matchWord(
    String expression,
  ) =>
      RegExp('^(${expression.toString()})\$').hasMatch(formatWord());

  bool blackListLetter(List<String> blacklist) =>
      blacklist.isEmpty ||
      blacklist
          .where((element) =>
              element.isNotEmpty && formatWord().contains(element.formatWord()))
          .toList()
          .isEmpty;

  bool whiteListLetter(List<String> whiteList) {
    if (whiteList.isEmpty) return true;
    var result = true;
    for (var element in whiteList) {
      if (!formatWord().contains(element.formatWord())) {
        if (length < 5 && element == 'S') continue;
        result = false;
        break;
      }
    }
    return result;
  }
}
