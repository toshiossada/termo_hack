import '../../../../commons/extensions/match_letter_extension.dart';
import '../entities/word_entity.dart';

class FilterPositionLettersUsecase {
  List<String> call({
    required WordEntity wordEntity,
    required List<String> words,
  }) {
    var result = words;
    for (var i = 1; i <= 5; i++) {
      final letters = wordEntity.notPositionLetter
          .where((element) => element.position == i)
          .toList();

      if (letters.isEmpty) continue;
      result = result
          .where((word) {
            return !letters.any((e) =>
                word.substring(e.position - 1, e.position).formatWord() ==
                e.letter.formatWord());
          })
          .map((e) => e.formatWord())
          .toList();
    }

    return result;
  }
}
