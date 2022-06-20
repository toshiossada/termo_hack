import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:termo/app/commons/extensions/match_letter_extension.dart';
import 'package:termo/app/words/domain/repositories/word_repository_interface.dart';
import 'package:termo/app/words/domain/usecases/build_plural_word_usecase.dart';
import 'package:termo/app/words/domain/usecases/search_words_usecase.dart';

import 'search_words_usecase_test.mocks.dart';

@GenerateMocks([IWordRepository])
void main() {
  late final SearchWordsUsecase usecase;
  late final BuildPluralWordUsecase buildPluralWordUsecase;
  final wordRepository = MockIWordRepository();

  setUpAll(() {
    buildPluralWordUsecase = BuildPluralWordUsecase();
    usecase = SearchWordsUsecase(
      wordRepository: wordRepository,
      buildPluralWord: buildPluralWordUsecase,
    );
  });

  test(
      '''
Dado a requisiçao de procura de palavras
Quando o repository me retornar palavras com acentos
Então deve retornar uma lista de palavras sem acentos e maiusculas
''',
      () async {
    final listWords = [
      'amigo',
      'animal',
      'azul',
      'coronel',
      'bar',
      'capaz',
      'freguês',
      'fuzil',
      'funil',
      'útil',
      'bagagem',
      'viagem',
      'mão',
      'melão',
    ];
    when(wordRepository.getWords()).thenAnswer((_) async => listWords);
    var result = await usecase.call();

    expect(result.any((element) => element == 'MAOS'.formatWord()), true);
    expect(result.any((element) => element == 'uteis'.formatWord()), true);
    expect(result.any((element) => element == 'FREGUES'.formatWord()), true);
    expect(result.any((element) => element == 'melão'.formatWord()), true);
  });

  test(
      '''
Dado a requisiçao de procura de palavras
Quando o repository me retornar palavras 3 palavras repetidas
Então deve retornar uma lista de palavras sem palavras repetidas
''',
      () async {
    final listWords = [
      'amigo',
      'amigo',
      'animal',
      'animal',
      'azul',
      'azul',
    ];
    when(wordRepository.getWords()).thenAnswer((_) async => listWords);
    var result = await usecase.call();

    expect(result.length, 3);
  });
}
