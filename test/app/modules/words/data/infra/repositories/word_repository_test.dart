import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:termo/app/modules/words/data/infra/repositories/word_repository.dart';
import 'package:termo/app/modules/words/data/infra/datasources/word_datasource_interface.dart';

import 'word_repository_test.mocks.dart';

@GenerateMocks([IWordDatasource])
void main() {
  late final WordRepository wordRepository;
  final wordDatasouce = MockIWordDatasource();

  setUpAll(() {
    wordRepository = WordRepository(wordDataSource: wordDatasouce);
  });

  test('''
Dado requisitaçào uma lista de palavras
Quando retornar palavras repetidas
Então deve retornar uma lista de palavras sem repetição
''', () async {
    when(wordDatasouce.getWords())
        .thenAnswer((_) async => ['amigo', 'amigo', 'animal']);
    var result = await wordRepository.getWords();

    expect(result.isNotEmpty, true);
    expect(result.where((element) => element == 'amigo').length, 1);
    expect(result.length, 2);
  });
  test('''
Dado requisitaçào uma lista de palavras
Quando retornar nenhuma palavra
Então deve retornar uma lista vazia
''', () async {
    when(wordDatasouce.getWords()).thenAnswer((_) async => []);
    var result = await wordRepository.getWords();

    expect(result.isEmpty, true);
  });
}
