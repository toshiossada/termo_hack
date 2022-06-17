import '../../../../shared/extensions/match_letter_extension.dart';
import '../entities/word_entity.dart';
import 'build_plural_word_usecase.dart';

class FilterWordsUsecase {
  final BuildPluralWordUsecase _buildPluralWord;

  FilterWordsUsecase({
    required BuildPluralWordUsecase buildPluralWord,
  }) : _buildPluralWord = buildPluralWord;

  List<String> call({
    required List<String> blackList,
    required List<String> whiteList,
    required WordEntity wordEntity,
    required List<String> words,
  }) {
    final filteredWords = <String>[];

    for (var element in words) {
      if (element.length >= 5) {
        filteredWords.add(element);
      } else {
        final plural = _buildPluralWord(word: element);
        filteredWords.addAll(plural);
      }
    }

    var result = words.where((word) {
      return word.blackListLetter(blackList);
    }).toList();

    result = result
        .where((word) => word.toUpperCase().whiteListLetter(whiteList))
        .toList();

    result = result.where((word) {
      return word.length == 5 &&
          word.matchLetter(letter: wordEntity.firstLetter, position: 1) &&
          word.matchLetter(letter: wordEntity.secondLetter, position: 2) &&
          word.matchLetter(letter: wordEntity.thirdLetter, position: 3) &&
          word.matchLetter(letter: wordEntity.fourthLetter, position: 4) &&
          word.matchLetter(letter: wordEntity.fifthLetter, position: 5);
    }).toList();

    return result;
  }
}
