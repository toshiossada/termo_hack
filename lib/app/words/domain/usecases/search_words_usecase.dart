import '../repositories/word_repository_interface.dart';

class SearchWordsUsecase {
  final IWordRepository _wordRepository;

  SearchWordsUsecase({
    required IWordRepository wordRepository,
  }) : _wordRepository = wordRepository;

  call() async {
    final result = await _wordRepository.getWords();

    return result;
  }
}
