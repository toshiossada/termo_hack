import 'package:flutter_test/flutter_test.dart';
import 'package:termo/app/commons/extensions/match_letter_extension.dart';
import 'package:termo/app/modules/words/domain/entities/letter_entity.dart';
import 'package:termo/app/modules/words/domain/entities/word_entity.dart';
import 'package:termo/app/modules/words/domain/usecases/filter_position_letters_usecase.dart';

void main() {
  late final FilterPositionLettersUsecase usecase;
  final words = [
    'amigo'.formatWord(),
    'azuis'.formatWord(),
    'bares'.formatWord(),
    'capaz'.formatWord(),
    'fuzil'.formatWord(),
    'úteis'.formatWord(),
    'banir'.formatWord(),
    'baniu'.formatWord(),
  ];
  setUpAll(() {
    usecase = FilterPositionLettersUsecase();
  });

  test('filter position letters usecase1 ...', () async {
    const letters = <LetterEnity>[];
    final wordEntity = WordEntity(notPositionLetter: letters);

    final result = usecase(
      wordEntity: wordEntity,
      words: words,
    );

    expect(words, result);
  });
  test('filter position letters usecase2 ...', () async {
    final containedWords = [
      'fuzil'.formatWord(),
      'úteis'.formatWord(),
    ];
    final notContainedWords = [
      'amigo'.formatWord(),
      'azuis'.formatWord(),
      'bares'.formatWord(),
      'capaz'.formatWord(),
      'banir'.formatWord(),
      'baniu'.formatWord(),
    ];
    final letters = <LetterEnity>[
      LetterEnity(letter: 'A', position: 1),
      LetterEnity(letter: 'A', position: 2),
    ];
    final wordEntity = WordEntity(notPositionLetter: letters);

    final result = usecase(
      wordEntity: wordEntity,
      words: words,
    );

    for (var element in containedWords) {
      expect(result, contains(element));
    }
    for (var element in notContainedWords) {
      expect(result.contains(element), isFalse);
    }
  });
  test('filter position letters usecase2 ...', () async {
    final containedWords = [
      'fuzil'.formatWord(),
      'úteis'.formatWord(),
      'bares'.formatWord(),
      'banir'.formatWord(),
      'baniu'.formatWord(),
    ];
    final notContainedWords = [
      'amigo'.formatWord(),
      'azuis'.formatWord(),
      'capaz'.formatWord(),
    ];
    final letters = <LetterEnity>[
      LetterEnity(letter: 'A', position: 1),
      LetterEnity(letter: 'C', position: 1),
    ];
    final wordEntity = WordEntity(notPositionLetter: letters);

    final result = usecase(
      wordEntity: wordEntity,
      words: words,
    );

    for (var element in containedWords) {
      expect(result, contains(element));
    }
    for (var element in notContainedWords) {
      expect(result.contains(element), isFalse);
    }
  });
  test('filter position letters usecase2 ...', () async {
    final containedWords = [
      'amigo'.formatWord(),
      'capaz'.formatWord(),
    ];
    final notContainedWords = [
      'fuzil'.formatWord(),
      'bares'.formatWord(),
      'baniu'.formatWord(),
      'azuis'.formatWord(),
      'banir'.formatWord(),
      'úteis'.formatWord(),
    ];
    final letters = <LetterEnity>[
      LetterEnity(letter: 'R', position: 3),
      LetterEnity(letter: 'I', position: 4),
      LetterEnity(letter: 'S', position: 5),
    ];
    final wordEntity = WordEntity(notPositionLetter: letters);

    final result = usecase(
      wordEntity: wordEntity,
      words: words,
    );

    for (var element in containedWords) {
      expect(result, contains(element));
    }
    for (var element in notContainedWords) {
      expect(result.contains(element), isFalse);
    }
  });
}
