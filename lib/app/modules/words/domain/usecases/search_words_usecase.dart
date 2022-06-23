import '../../../../commons/extensions/match_letter_extension.dart';
import '../repositories/word_repository_interface.dart';
import 'build_plural_word_usecase.dart';

class SearchWordsUsecase {
  final IWordRepository _wordRepository;
  final BuildPluralWordUsecase _buildPluralWord;

  SearchWordsUsecase({
    required IWordRepository wordRepository,
    required BuildPluralWordUsecase buildPluralWord,
  })  : _wordRepository = wordRepository,
        _buildPluralWord = buildPluralWord;

  Future<List<String>> call() async {
    final words = await _wordRepository.getWords();
    final result = <String>[];

    for (var element in words) {
      if (element.length >= 5) {
        result.add(element.formatWord());
      } else {
        final plural = _buildPluralWord(word: element);
        result.addAll(plural.map<String>((e) => e.formatWord()).toList());
      }
    }

    return result.toSet().toList();
  }
}
