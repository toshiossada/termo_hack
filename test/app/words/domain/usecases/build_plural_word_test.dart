import 'package:diacritic/diacritic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:termo/app/words/domain/usecases/build_plural_word_usecase.dart';

extension TestStr on String {
  toTestableStr() => removeDiacritics(toUpperCase());
}

void main() {
  final usecase = BuildPluralWordUsecase();

  group('palavra sem nenhum tratamento especial', () {
    test(
        '''
Dado a palavra AMIGO
Quando a palavra não tem nenhum tratamento especial
Então deve Retornar AMIGOS
''',
        () async {
      const word = 'amigo';
      const expectWord = 'amigos';
      final result = usecase(word: word);

      expect(result.length, 1);
      expect(result.first, expectWord.toTestableStr());
    });
  });
  group(
      '''
Quando a palavra for terminada em -al, -el, -ol ou -ul
Então deve fazer o plural trocando o -l por -is
''',
      () {
    test(
        '''
Dado a palavra animal
Quando a palavra for terminada em -al, -el, -ol ou -ul
Então deve fazer o plural trocando o -l por -is
E Retornar animais
''',
        () async {
      const word = 'animal';
      const expectWord = 'animais';
      final result = usecase(word: word);

      expect(result.length, 1);
      expect(result.first, expectWord.toTestableStr());
    });
    test(
        '''
Dado a palavra azul
Quando a palavra for terminada em -al, -el, -ol ou -ul
Então deve fazer o plural trocando o -l por -is
E Retornar azuis
''',
        () async {
      const word = 'azul';
      const expectWord = 'azuis';
      final result = usecase(word: word);

      expect(result.length, 1);
      expect(result.first, expectWord.toTestableStr());
    });
    test(
        '''
Dado a palavra coronel
Quando a palavra for terminada em -al, -el, -ol ou -ul
Então deve fazer o plural trocando o -l por -is
E Retornar  coronéis
''',
        () async {
      const word = 'coronel';
      const expectWord = 'coronéis';
      final result = usecase(word: word);

      expect(result.length, 1);
      expect(result.first, expectWord.toTestableStr());
    });
  });

  group(
      '''
Quando a palavra for terminada em –r, -s, ou -z
Então deve fazer o plural com –es
''',
      () {
    test(
        '''
Dado a palavra bar
Quando a palavra for terminada em  –r, -s, ou -z
Então deve fazer o plural com –es
E Retornar BARES.
''',
        () async {
      const word = 'bar';
      const expectWord = 'BARES';
      final result = usecase(word: word);

      expect(result.length, 1);
      expect(result.first, expectWord.toTestableStr());
    });
    test(
        '''
Dado a palavra capaz
Quando a palavra for terminada em  –r, -s, ou -z
Então deve fazer o plural com –es
E Retornar capazes.
''',
        () async {
      const word = 'capaz';
      const expectWord = 'capazes';
      final result = usecase(word: word);

      expect(result.length, 1);
      expect(result.first, expectWord.toTestableStr());
    });
    test(
        '''
Dado a palavra freguês
Quando a palavra for terminada em  –r, -s, ou -z
Então deve fazer o plural com –es
E Retornar fregueses.
''',
        () async {
      const word = 'freguês';
      const expectWord = 'fregueses';
      final result = usecase(word: word);

      expect(result.length, 1);
      expect(result.first, expectWord.toTestableStr());
    });
  });

  group(
      '''
Quando a palavra for terminada em –il
Então deve fazer o plural trocando o -l por -s
OU trocando o -il por -eis
''',
      () {
    test(
        '''
Dado a palavra fuzil
Quando a palavra for terminada em  -il,
Então deve fazer o plural trocando o -l por -s
OU trocando o -il por -eis
E Retornar fuzis.
''',
        () async {
      const word = 'fuzil';
      const expectWord = 'fuzis';
      final result = usecase(word: word);

      expect(result.length, 2);
      expect(
          result.any((element) => element == expectWord.toTestableStr()), true);
    });
    test(
        '''
Dado a palavra funil
Quando a palavra for terminada em  -il,
Então deve fazer o plural trocando o -l por -s
OU trocando o -il por -eis
E Retornar funis.
''',
        () async {
      const word = 'funil';
      const expectWord = 'funis';
      final result = usecase(word: word);

      expect(result.length, 2);
      expect(
          result.any((element) => element == expectWord.toTestableStr()), true);
    });

    test(
        '''
Dado a palavra útil
Quando a palavra for terminada em  -il,
Então deve fazer o plural trocando o -l por -s
OU trocando o -il por -eis
E Retornar úteis.
''',
        () async {
      const word = 'útil';
      const expectWord = 'úteis';
      final result = usecase(word: word);

      expect(result.length, 2);
      expect(
          result.any((element) => element == expectWord.toTestableStr()), true);
    });
  });

  group(
      '''
Quando a palavra for terminada em -m,
Então deve fazer o plural trocando o -m por -ns
''',
      () {
    test(
        '''
Dado a palavra bagagem
Quando a palavra for terminada em -m,
Então deve fazer o plural trocando o -m por -ns
E Retornar bagagens.
''',
        () async {
      const word = 'bagagem ';
      const expectWord = 'bagagens';
      final result = usecase(word: word);

      expect(result.length, 1);
      expect(result.first, expectWord.toTestableStr());
    });
    test(
        '''
Dado a palavra viagem
Quando a palavra for terminada em -m,
Então deve fazer o plural trocando o -m por -ns
E Retornar viagens.
''',
        () async {
      const word = 'viagem';
      const expectWord = 'viagens';
      final result = usecase(word: word);

      expect(result.length, 1);
      expect(result.first, expectWord.toTestableStr());
    });
  });

  group(
      '''
Quando a palavra for terminada em -ão,
Então deve fazer o plural trocando o -ãos ou por -ães
''',
      () {
    test(
        '''
Dado a palavra mão
Quando a palavra for terminada em -ão,
Então deve fazer o plural trocando o -ãos ou por -ães
E Retornar mãos.
''',
        () async {
      const word = 'mão';
      const expectWord = 'mãos';
      final result = usecase(word: word);

      expect(result.length, 2);
      expect(
          result.any((element) => element == expectWord.toTestableStr()), true);
    });
    test(
        '''
Dado a palavra melão
Quando a palavra for terminada em -ão,
Então deve fazer o plural trocando o -ãos ou por -ães
E Retornar melões.
''',
        () async {
      const word = 'melão';
      const expectWord = 'melões';
      final result = usecase(word: word);

      expect(result.length, 2);
      expect(
          result.any((element) => element == expectWord.toTestableStr()), true);
    });
  });
}
