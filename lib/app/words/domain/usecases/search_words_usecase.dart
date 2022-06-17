import '../../../../shared/extensions/match_letter_extension.dart';
import '../entities/word_entity.dart';
import '../repositories/word_repository_interface.dart';
import 'build_plural_word.dart';

class SearchWordsUsecase {
  final IWordRepository _wordRepository;
  final BuildPluralWord _buildPluralWord;

  SearchWordsUsecase(
      {required IWordRepository wordRepository,
      required BuildPluralWord buildPluralWord})
      : _wordRepository = wordRepository,
        _buildPluralWord = buildPluralWord;

  call({
    required List<String> blackList,
    required List<String> whiteList,
    required WordEntity wordEntity,
  }) async {
    final repositoryWords = await _wordRepository.getWords();
    final words = <String>[];

    for (var element in repositoryWords) {
      if (element.length >= 5) {
        words.add(element);
      } else {
        final plural = _buildPluralWord(word: element);
        words.addAll(plural);
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
