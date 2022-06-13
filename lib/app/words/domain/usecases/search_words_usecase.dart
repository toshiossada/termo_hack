import '../../../../shared/extensions/match_letter_extension.dart';
import '../entities/word_entity.dart';
import '../repositories/word_repository_interface.dart';

class SearchWordsUsecase {
  final IWordRepository _wordRepository;

  SearchWordsUsecase({required IWordRepository wordRepository})
      : _wordRepository = wordRepository;

  call({
    required List<String> blackList,
    required List<String> whiteList,
    required WordEntity wordEntity,
  }) async {
    print('s');
    final words = await _wordRepository.getWords();
    print(words);

    var result = words.where((word) {
      return word.length >= 4 && word.blackListLetter(blackList);
    }).toList();

    result = result
        .where((word) => word.toUpperCase().whiteListLetter(whiteList))
        .toList();

    result = result.where((word) {
      return word.matchLetter(letter: wordEntity.firstLetter, position: 1) &&
          word.matchLetter(letter: wordEntity.secondLetter, position: 2) &&
          word.matchLetter(letter: wordEntity.thirdLetter, position: 3) &&
          word.matchLetter(letter: wordEntity.fourthLetter, position: 4) &&
          (word.length < 5 ||
              word.matchLetter(letter: wordEntity.fifthLetter, position: 5));
    }).toList();

    return result;
  }
}
