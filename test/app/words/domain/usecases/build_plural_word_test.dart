import 'package:diacritic/diacritic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:termo/app/words/domain/usecases/build_plural_word.dart';

extension TestStr on String {
  toTestableStr() => removeDiacritics(toUpperCase());
}

void main() {
  final usecase = BuildPluralWord();

  testWidgets(
      '''
Dado a palavra AMIGO
Quando a palavra não tem nenhum tratamento especial
Deve Retornar AMIGOS
''',
      (tester) async {
    const word = 'amigo';
    const expectWord = 'amigos';
    final result = usecase(word: word);

    expect(result.length, 1);
    expect(result.first, expectWord.toTestableStr());
  });

  testWidgets(
      '''
Dado a palavra animal
Quando a palavra for terminada em -al, -el, -ol ou -ul
Deve fazer o plural trocando o -l por -is
E Retornar animais
''',
      (tester) async {
    const word = 'animal';
    const expectWord = 'animais';
    final result = usecase(word: word);

    expect(result.length, 1);
    expect(result.first, expectWord.toTestableStr());
  });
  testWidgets(
      '''
Dado a palavra azul
Quando a palavra for terminada em -al, -el, -ol ou -ul
Deve fazer o plural trocando o -l por -is
E Retornar azuis
''',
      (tester) async {
    const word = 'azul';
    const expectWord = 'azuis';
    final result = usecase(word: word);

    expect(result.length, 1);
    expect(result.first, expectWord.toTestableStr());
  });
  testWidgets(
      '''
Dado a palavra coronel
Quando a palavra for terminada em -al, -el, -ol ou -ul
Deve fazer o plural trocando o -l por -is
E Retornar  coronéis
''',
      (tester) async {
    const word = 'coronel';
    const expectWord = 'coronéis';
    final result = usecase(word: word);

    expect(result.length, 1);
    expect(result.first, expectWord.toTestableStr());
  });

  testWidgets(
      '''
Dado a palavra bar
Quando a palavra for terminada em  –r, -s, ou -z
Deve fazer o plural com –es
E Retornar BARES.
''',
      (tester) async {
    const word = 'bar';
    const expectWord = 'BARES';
    final result = usecase(word: word);

    expect(result.length, 1);
    expect(result.first, expectWord.toTestableStr());
  });
  testWidgets(
      '''
Dado a palavra capaz
Quando a palavra for terminada em  –r, -s, ou -z
Deve fazer o plural com –es
E Retornar capazes.
''',
      (tester) async {
    const word = 'capaz';
    const expectWord = 'capazes';
    final result = usecase(word: word);

    expect(result.length, 1);
    expect(result.first, expectWord.toTestableStr());
  });
  testWidgets(
      '''
Dado a palavra freguês
Quando a palavra for terminada em  –r, -s, ou -z
Deve fazer o plural com –es
E Retornar fregueses.
''',
      (tester) async {
    const word = 'freguês';
    const expectWord = 'fregueses';
    final result = usecase(word: word);

    expect(result.length, 1);
    expect(result.first, expectWord.toTestableStr());
  });

  testWidgets(
      '''
Dado a palavra fuzil
Quando a palavra for terminada em  -il,
Deve fazer o plural trocando o -l por -s
OU trocando o -il por -eis
E Retornar fuzis.
''',
      (tester) async {
    const word = 'fuzil';
    const expectWord = 'fuzis';
    final result = usecase(word: word);

    expect(result.length, 2);
    expect(
        result.any((element) => element == expectWord.toTestableStr()), true);
  });
  testWidgets(
      '''
Dado a palavra funil
Quando a palavra for terminada em  -il,
Deve fazer o plural trocando o -l por -s
OU trocando o -il por -eis
E Retornar funis.
''',
      (tester) async {
    const word = 'funil';
    const expectWord = 'funis';
    final result = usecase(word: word);

    expect(result.length, 2);
    expect(
        result.any((element) => element == expectWord.toTestableStr()), true);
  });
  testWidgets(
      '''
Dado a palavra útil
Quando a palavra for terminada em  -il,
Deve fazer o plural trocando o -l por -s
OU trocando o -il por -eis
E Retornar úteis.
''',
      (tester) async {
    const word = 'útil';
    const expectWord = 'úteis';
    final result = usecase(word: word);

    expect(result.length, 2);
    expect(
        result.any((element) => element == expectWord.toTestableStr()), true);
  });

  testWidgets(
      '''
Dado a palavra bagagem
Quando a palavra for terminada em -m,
Deve fazer o plural trocando o -m por -ns
E Retornar bagagens.
''',
      (tester) async {
    const word = 'bagagem ';
    const expectWord = 'bagagens';
    final result = usecase(word: word);

    expect(result.length, 1);
    expect(result.first, expectWord.toTestableStr());
  });
  testWidgets(
      '''
Dado a palavra viagem
Quando a palavra for terminada em -m,
Deve fazer o plural trocando o -m por -ns
E Retornar viagens.
''',
      (tester) async {
    const word = 'viagem';
    const expectWord = 'viagens';
    final result = usecase(word: word);

    expect(result.length, 1);
    expect(result.first, expectWord.toTestableStr());
  });

  testWidgets(
      '''
Dado a palavra mão
Quando a palavra for terminada em -ão,
Deve fazer o plural trocando o -ãos por -ães
E Retornar mãos.
''',
      (tester) async {
    const word = 'mão';
    const expectWord = 'mãos';
    final result = usecase(word: word);

    expect(result.length, 2);
    expect(
        result.any((element) => element == expectWord.toTestableStr()), true);
  });
  testWidgets(
      '''
Dado a palavra melão
Quando a palavra for terminada em -ão,
Deve fazer o plural trocando o -ãos por -ães
E Retornar melões.
''',
      (tester) async {
    const word = 'melão';
    const expectWord = 'melões';
    final result = usecase(word: word);

    expect(result.length, 2);
    expect(
        result.any((element) => element == expectWord.toTestableStr()), true);
  });
}
