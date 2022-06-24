import '../../../../commons/extensions/match_letter_extension.dart';
import 'letter_entity.dart';

class WordEntity {
  final String firstLetter;
  final String secondLetter;
  final String thirdLetter;
  final String fourthLetter;
  final String fifthLetter;

  final List<LetterEnity> notPositionLetter;

  WordEntity? addNotPositionLetter(int position, String letter) {
    if (!notPositionLetter.any((element) =>
        element.letter == letter.formatWord() &&
        element.position == position)) {
      return copyWith(
          notPositionLetter: List.from(notPositionLetter)
            ..add(
                LetterEnity(position: position, letter: letter.formatWord())));
    }
    return null;
  }

  WordEntity? removeNotPositionLetter(int position, String letter) {
    if (notPositionLetter.any((element) =>
        element.letter == letter.formatWord() &&
        element.position == position)) {
      return copyWith(
          notPositionLetter: List.from(notPositionLetter)
            ..remove(notPositionLetter.firstWhere((element) =>
                element.letter == letter.formatWord() &&
                element.position == position)));
    }
    return null;
  }

  WordEntity({
    this.firstLetter = '',
    this.secondLetter = '',
    this.thirdLetter = '',
    this.fourthLetter = '',
    this.fifthLetter = '',
    this.notPositionLetter = const [],
  });

  WordEntity copyWith({
    String? firstLetter,
    String? secondLetter,
    String? thirdLetter,
    String? fourthLetter,
    String? fifthLetter,
    List<LetterEnity>? notPositionLetter,
  }) {
    return WordEntity(
      firstLetter: firstLetter ?? this.firstLetter,
      secondLetter: secondLetter ?? this.secondLetter,
      thirdLetter: thirdLetter ?? this.thirdLetter,
      fourthLetter: fourthLetter ?? this.fourthLetter,
      fifthLetter: fifthLetter ?? this.fifthLetter,
      notPositionLetter: notPositionLetter ?? this.notPositionLetter,
    );
  }
}
