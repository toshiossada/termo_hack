import '../../domain/entities/word_entity.dart';

class WordsViewModel {
  final bool loading;
  final List<String> blackList;

  final List<String> whiteList;
  final List<String> words;
  final WordEntity word;

  WordsViewModel({
    this.loading = true,
    this.blackList = const [],
    this.whiteList = const [],
    this.words = const [],
    WordEntity? word,
  }) : word = word ?? WordEntity();

  WordsViewModel copyWith({
    bool? loading,
    List<String>? blackList,
    List<String>? whiteList,
    List<String>? words,
    WordEntity? word,
  }) {
    return WordsViewModel(
      loading: loading ?? this.loading,
      blackList: blackList ?? this.blackList,
      whiteList: whiteList ?? this.whiteList,
      words: words ?? this.words,
      word: word ?? this.word,
    );
  }
}
