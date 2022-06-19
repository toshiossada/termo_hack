import 'package:flutter_test/flutter_test.dart';
import 'package:termo/app/words/domain/entities/word_entity.dart';
import 'package:termo/app/words/domain/usecases/filter_words_usecase.dart';

void main() {
  late final FilterWordsUsecase usecase;
  final words = [
    'amigo',
    'animal',
    'azuis',
    'coronel',
    'bares',
    'capaz',
    'freguês',
    'fuzil',
    'funil',
    'úteis',
    'bagagem',
    'viagem',
    'mãos',
    'melãoes',
    'cãos',
    'banir',
    'baniu',
  ];
  setUpAll(() {
    usecase = FilterWordsUsecase();
  });

  testWidgets('''
Dado uma lista de palavras
Quando a blacklist for vazia
E a whitelist for vazia
E nenhuma letra for digitada
Então deve  retornar as palavras AMIGO, AZUIS, BARES, CAPAZ, FUZIL, BANIU, FUNIL E UTEIS
''', (tester) async {
    final blacklist = <String>[];
    final whitelist = <String>[];
    final wordEntity = WordEntity();

    var result = usecase.call(
      blackList: blacklist,
      whiteList: whitelist,
      wordEntity: wordEntity,
      words: words,
    );

    expect(result.any((element) => element.length != 5), false);
    expect(result.any((element) => element == 'AZUIS'), true);
    expect(result.any((element) => element == 'FUZIL'), true);
    expect(result.any((element) => element == 'FUNIL'), true);
    expect(result.any((element) => element == 'BANIU'), true);
    expect(result.any((element) => element == 'UTEIS'), true);
    expect(result.any((element) => element == 'BARES'), true);
    expect(result.any((element) => element == 'CAPAZ'), true);
    expect(result.any((element) => element == 'AMIGO'), true);
  });

  testWidgets('''
Dado uma lista de palavras
Quando a blacklist tiver a letra U
E a whitelist for vazia
E nenhuma letra for digitada
Então NÃO deve  retornar as palavras FUNIL, AZUIS, BANIU, UTEIS e FUZIL
''', (tester) async {
    final blacklist = <String>['U'];
    final whitelist = <String>[];
    final wordEntity = WordEntity();

    var result = usecase.call(
      blackList: blacklist,
      whiteList: whitelist,
      wordEntity: wordEntity,
      words: words,
    );

    expect(result.any((element) => element.length != 5), false);
    expect(result.any((element) => element == 'AZUIS'), false);
    expect(result.any((element) => element == 'FUZIL'), false);
    expect(result.any((element) => element == 'FUNIL'), false);
    expect(result.any((element) => element == 'BANIU'), false);
    expect(result.any((element) => element == 'UTEIS'), false);
    expect(result.any((element) => element == 'BARES'), true);
    expect(result.any((element) => element == 'CAPAZ'), true);
    expect(result.any((element) => element == 'AMIGO'), true);
  });
  testWidgets('''
Dado uma lista de palavras
Quando a blacklist tiver a letra U
E a whitelist tiver a letra A
E nenhuma letra for digitada
Então NÃO deve  retornar as palavras FUNIL, AZUIS, BANIU, UTEIS e FUZIL
''', (tester) async {
    final blacklist = <String>['U'];
    final whitelist = <String>['A'];
    final wordEntity = WordEntity();

    var result = usecase.call(
      blackList: blacklist,
      whiteList: whitelist,
      wordEntity: wordEntity,
      words: words,
    );

    expect(result.any((element) => element.length != 5), false);
    expect(result.any((element) => element == 'AZUIS'), false);
    expect(result.any((element) => element == 'FUZIL'), false);
    expect(result.any((element) => element == 'FUNIL'), false);
    expect(result.any((element) => element == 'BANIU'), false);
    expect(result.any((element) => element == 'UTEIS'), false);
    expect(result.any((element) => element == 'BARES'), true);
    expect(result.any((element) => element == 'CAPAZ'), true);
    expect(result.any((element) => element == 'AMIGO'), true);
  });
  testWidgets('''
Dado uma lista de palavras
Quando a blacklist tiver a letra U
E a whitelist tiver a letra 'A' e 'I'
E nenhuma letra for digitada
Então NÃO deve  retornar as palavras FUNIL, AZUIS, BANIU, UTEIS e FUZIL
''', (tester) async {
    final blacklist = <String>['U'];
    final whitelist = <String>['A', 'I'];
    final wordEntity = WordEntity();

    var result = usecase.call(
      blackList: blacklist,
      whiteList: whitelist,
      wordEntity: wordEntity,
      words: words,
    );

    expect(result.any((element) => element.length != 5), false);
    expect(result.any((element) => element == 'AZUIS'), false);
    expect(result.any((element) => element == 'FUZIL'), false);
    expect(result.any((element) => element == 'FUNIL'), false);
    expect(result.any((element) => element == 'BANIU'), false);
    expect(result.any((element) => element == 'UTEIS'), false);
    expect(result.any((element) => element == 'BARES'), false);
    expect(result.any((element) => element == 'CAPAZ'), false);
    expect(result.any((element) => element == 'AMIGO'), true);
  });
  testWidgets('''
Dado uma lista de palavras
Quando a blacklist tiver vazia
E a whitelist tiver vazia
E a primeira letra for A
Então deve  retornar a palavra AMIGO e AZUIS
''', (tester) async {
    final blacklist = <String>[];
    final whitelist = <String>[];
    final wordEntity = WordEntity(firstLetter: 'A');

    var result = usecase.call(
      blackList: blacklist,
      whiteList: whitelist,
      wordEntity: wordEntity,
      words: words,
    );

    expect(result.any((element) => element.length != 5), false);
    expect(result.any((element) => element == 'FUZIL'), false);
    expect(result.any((element) => element == 'FUNIL'), false);
    expect(result.any((element) => element == 'UTEIS'), false);
    expect(result.any((element) => element == 'AZUIS'), true);
    expect(result.any((element) => element == 'BANIU'), false);
    expect(result.any((element) => element == 'BARES'), false);
    expect(result.any((element) => element == 'CAPAZ'), false);
    expect(result.any((element) => element == 'AMIGO'), true);
  });
  testWidgets('''
Dado uma lista de palavras
Quando a blacklist tiver vazia
E a whitelist tiver vazia
E segunda letra for L
Então deve retornar nenhuma palavra
''', (tester) async {
    final blacklist = <String>[];
    final whitelist = <String>[];
    final wordEntity = WordEntity(secondLetter: 'L');

    var result = usecase.call(
      blackList: blacklist,
      whiteList: whitelist,
      wordEntity: wordEntity,
      words: words,
    );

    expect(result.any((element) => element.length != 5), false);
    expect(result.isEmpty, true);
    expect(result.any((element) => element == 'FUZIL'), false);
    expect(result.any((element) => element == 'FUNIL'), false);
    expect(result.any((element) => element == 'UTEIS'), false);
    expect(result.any((element) => element == 'AZUIS'), false);
    expect(result.any((element) => element == 'BANIU'), false);
    expect(result.any((element) => element == 'BARES'), false);
    expect(result.any((element) => element == 'CAPAZ'), false);
    expect(result.any((element) => element == 'AMIGO'), false);
  });
  testWidgets('''
Dado uma lista de palavras
Quando a blacklist tiver vazia
E a whitelist tiver vazia
E terceira letra for Z
Então deve retornar FUZIL
''', (tester) async {
    final blacklist = <String>[];
    final whitelist = <String>[];
    final wordEntity = WordEntity(thirdLetter: 'Z');

    var result = usecase.call(
      blackList: blacklist,
      whiteList: whitelist,
      wordEntity: wordEntity,
      words: words,
    );

    expect(result.any((element) => element.length != 5), false);
    expect(result.isEmpty, false);
    expect(result.any((element) => element == 'FUZIL'), true);
    expect(result.any((element) => element == 'FUNIL'), false);
    expect(result.any((element) => element == 'UTEIS'), false);
    expect(result.any((element) => element == 'AZUIS'), false);
    expect(result.any((element) => element == 'BANIU'), false);
    expect(result.any((element) => element == 'BARES'), false);
    expect(result.any((element) => element == 'CAPAZ'), false);
    expect(result.any((element) => element == 'AMIGO'), false);
  });
  testWidgets('''
Dado uma lista de palavras
Quando a blacklist tiver vazia
E a whitelist tiver vazia
E terceira quarta for I
Então deve retornar nenhuma palavra FUZIL, FUNIL, UTEIS, AZUIS e BANIU
''', (tester) async {
    final blacklist = <String>[];
    final whitelist = <String>[];
    final wordEntity = WordEntity(fourthLetter: 'I');

    var result = usecase.call(
      blackList: blacklist,
      whiteList: whitelist,
      wordEntity: wordEntity,
      words: words,
    );

    expect(result.any((element) => element.length != 5), false);
    expect(result.isEmpty, false);
    expect(result.any((element) => element == 'FUZIL'), true);
    expect(result.any((element) => element == 'FUNIL'), true);
    expect(result.any((element) => element == 'UTEIS'), true);
    expect(result.any((element) => element == 'AZUIS'), true);
    expect(result.any((element) => element == 'BANIU'), true);
    expect(result.any((element) => element == 'BARES'), false);
    expect(result.any((element) => element == 'CAPAZ'), false);
    expect(result.any((element) => element == 'AMIGO'), false);
  });

  testWidgets('''
Dado uma lista de palavras
Quando a blacklist tiver vazia
E a whitelist tiver vazia
E terceira quinta for L
Então deve retornar nenhuma palavra FUZIL e FUNIL
''', (tester) async {
    final blacklist = <String>[];
    final whitelist = <String>[];
    final wordEntity = WordEntity(fifthLetter: 'l');

    var result = usecase.call(
      blackList: blacklist,
      whiteList: whitelist,
      wordEntity: wordEntity,
      words: words,
    );

    expect(result.any((element) => element.length != 5), false);
    expect(result.isEmpty, false);
    expect(result.any((element) => element == 'FUZIL'), true);
    expect(result.any((element) => element == 'FUNIL'), true);
    expect(result.any((element) => element == 'UTEIS'), false);
    expect(result.any((element) => element == 'AZUIS'), false);
    expect(result.any((element) => element == 'BANIU'), false);
    expect(result.any((element) => element == 'BARES'), false);
    expect(result.any((element) => element == 'CAPAZ'), false);
    expect(result.any((element) => element == 'AMIGO'), false);
  });

  testWidgets('''
Dado uma lista de palavras
Quando a blacklist tiver vazia
E a whitelist tiver vazia
E terceira quarta for I e a quinta for S
Então deve retornar nenhuma palavra  UTEIS e AZUIS
''', (tester) async {
    final blacklist = <String>[];
    final whitelist = <String>[];
    final wordEntity = WordEntity(
      fourthLetter: 'i',
      fifthLetter: 's',
    );

    var result = usecase.call(
      blackList: blacklist,
      whiteList: whitelist,
      wordEntity: wordEntity,
      words: words,
    );

    expect(result.any((element) => element.length != 5), false);
    expect(result.isEmpty, false);
    expect(result.any((element) => element == 'FUZIL'), false);
    expect(result.any((element) => element == 'FUNIL'), false);
    expect(result.any((element) => element == 'UTEIS'), true);
    expect(result.any((element) => element == 'AZUIS'), true);
    expect(result.any((element) => element == 'BANIU'), false);
    expect(result.any((element) => element == 'BARES'), false);
    expect(result.any((element) => element == 'CAPAZ'), false);
    expect(result.any((element) => element == 'AMIGO'), false);
  });
}
