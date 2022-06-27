import '../../../../commons/extensions/match_letter_extension.dart';
import '../entities/word_entity.dart';

class FilterWordsUsecase {
  List<String> call({
    required List<String> blackList,
    required List<String> whiteList,
    required WordEntity wordEntity,
    required List<String> words,
  }) {
    var result = words.where((word) {
      return word.formatWord().blackListLetter(blackList);
    }).toList();

    result = result
        .where((word) => word.formatWord().whiteListLetter(whiteList))
        .toList();

    result = result
        .where((word) => word.matchWord(_buildExpression(wordEntity)))
        .map((e) => e.formatWord())
        .toList();
    // result = result
    //     .where((word) =>
    //         word.length == 5 &&
    //         word.matchLetter(letter: wordEntity.firstLetter, position: 1) &&
    //         word.matchLetter(letter: wordEntity.secondLetter, position: 2) &&
    //         word.matchLetter(letter: wordEntity.thirdLetter, position: 3) &&
    //         word.matchLetter(letter: wordEntity.fourthLetter, position: 4) &&
    //         word.matchLetter(letter: wordEntity.fifthLetter, position: 5))
    //     .map((e) => e.formatWord())
    //     .toList();
    return result;
  }

  String _buildExpression(WordEntity wordEntity) {
    final sb = StringBuffer('');
    sb.write(wordEntity.firstLetter.isEmpty
        ? '.'
        : wordEntity.firstLetter.formatWord());
    sb.write(wordEntity.secondLetter.isEmpty
        ? '.'
        : wordEntity.secondLetter.formatWord());
    sb.write(wordEntity.thirdLetter.isEmpty
        ? '.'
        : wordEntity.thirdLetter.formatWord());
    sb.write(wordEntity.fourthLetter.isEmpty
        ? '.'
        : wordEntity.fourthLetter.formatWord());
    sb.write(wordEntity.fifthLetter.isEmpty
        ? '.'
        : wordEntity.fifthLetter.formatWord());

    return sb.toString();
  }
}
