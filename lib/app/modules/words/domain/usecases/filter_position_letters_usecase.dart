import '../../../../commons/extensions/match_letter_extension.dart';
import '../entities/letter_entity.dart';
import '../entities/word_entity.dart';

class FilterPositionLettersUsecase {
  List<String> call({
    required WordEntity wordEntity,
    required List<String> words,
  }) {
    var result = words;

    // final expression = _buildRegex(wordEntity.notPositionLetter);
    // for (var i = 1; i <= 5; i++) {
    //   final letters = wordEntity.notPositionLetter
    //       .where((element) => element.position == i)
    //       .toList();

    //   if (letters.isEmpty) continue;
    //   result = result
    //       .where((word) {
    //         return !letters.any((e) =>
    //             word.substring(e.position - 1, e.position).formatWord() ==
    //             e.letter.formatWord());
    //       })
    //       .map((e) => e.formatWord())
    //       .toList();
    // }

    return result = result
        .where(
            (word) => word.matchWord(_buildRegex(wordEntity.notPositionLetter)))
        .map((e) => e.formatWord())
        .toList();
  }

  String _buildRegex(List<LetterEnity> letters) {
    final sb = StringBuffer('');
    sb.write('[^${_buildExpression(letters, 1)}]');
    sb.write('[^${_buildExpression(letters, 2)}]');
    sb.write('[^${_buildExpression(letters, 3)}]');
    sb.write('[^${_buildExpression(letters, 4)}]');
    sb.write('[^${_buildExpression(letters, 5)}]');

    return sb.toString();
  }

  String _buildExpression(List<LetterEnity> letters, int position) {
    return letters.any((e) => e.position == position)
        ? letters
            .where((e) => e.position == position)
            .map((e) => e.letter)
            .toList()
            .join()
        : '.';
  }
}
