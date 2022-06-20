import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';
import 'package:termo/app/app_module.dart';
import 'package:termo/app/commons/adapters/http_client/http_client_adapter.dart';
import 'package:termo/app/commons/adapters/http_client/http_response.dart';
import 'package:termo/app/words/presentation/pages/home/home_page.dart';
import 'package:termo/app/words/words_module.dart';

import '../../../../../helpers/make_testable_widget.dart';
import 'home_page_test.mocks.dart';

@GenerateMocks([IHttpClientAdapter, IModularNavigator])
void main() {
  final http = MockIHttpClientAdapter();
  final navigate = MockIModularNavigator();

  setUp(() {
    initModules([
      AppModule(),
      WordsModule(),
    ], replaceBinds: [
      Bind.instance<IHttpClientAdapter>(http),
    ]);
    final words = [
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
    final response =
        HttpResponse(statusCode: 200, data: json.encode({'words': words}));
    when(http.get(any)).thenAnswer((_) async => response);

    Modular.navigatorDelegate = navigate;
  });

  testWidgets(
      '''
Dado uma lista de palavras
Quando a página é carregada
Deve exibir as palavras com 5 caracteres
''',
      (tester) async {
    await tester.pumpWidget(makeTestableWidget(child: const HomePage()));
    await tester.pumpAndSettle();
    final txtFirst = find.descendant(
        of: find.byKey(const Key('firstLetter')),
        matching: find.byType(TextField));
    final txtSecond = find.descendant(
        of: find.byKey(const Key('secondLetter')),
        matching: find.byType(TextField));
    final txtThird = find.descendant(
        of: find.byKey(const Key('thirdLetter')),
        matching: find.byType(TextField));
    final txtFourth = find.descendant(
        of: find.byKey(const Key('fourthLetter')),
        matching: find.byType(TextField));
    final txtFifth = find.descendant(
        of: find.byKey(const Key('fifthLetter')),
        matching: find.byType(TextField));
    await tester.pumpAndSettle();

    final animal = find.text('ANIMAL');
    final capaz = find.text('CAPAZ');
    final melao = find.text('MELAO');
    final fuzil = find.text('FUZIL');
    final funil = find.text('FUNIL');

    expect(txtFirst, findsOneWidget);
    expect(txtSecond, findsOneWidget);
    expect(txtThird, findsOneWidget);
    expect(txtFourth, findsOneWidget);
    expect(txtFifth, findsOneWidget);
    expect(animal, findsNothing);
    expect(capaz, findsWidgets);
    expect(melao, findsWidgets);
    expect(fuzil, findsWidgets);
    expect(funil, findsWidgets);
  });
  testWidgets(
      '''
Dado uma lista de palavras
Quando digitado a letra F na primeira caixa de texto
Deve exibir as palavras FUNIL e FUZIL
''',
      (tester) async {
    await tester.pumpWidget(makeTestableWidget(child: const HomePage()));
    await tester.pumpAndSettle();
    final txtFirst = find.descendant(
        of: find.byKey(const Key('firstLetter')),
        matching: find.byType(TextField));
    await tester.pumpAndSettle();

    await tester.enterText(txtFirst, 'F');

    await tester.pumpAndSettle();
    final animal = find.text('ANIMAL');
    final capaz = find.text('CAPAZ');
    final melao = find.text('MELAO');
    final fuzil = find.text('FUZIL');
    final funil = find.text('FUNIL');

    expect(txtFirst, findsOneWidget);
    expect(animal, findsNothing);
    expect(capaz, findsNothing);
    expect(melao, findsNothing);
    expect(fuzil, findsWidgets);
    expect(funil, findsWidgets);
  });
  testWidgets(
      '''
Dado uma lista de palavras
Quando limpar a tela
E digitado a letra E na segunda caixa de texto
Deve exibir as palavra MELAO
''',
      (tester) async {
    await tester.pumpWidget(makeTestableWidget(child: const HomePage()));
    await tester.pumpAndSettle();

    final txtSecond = find.descendant(
        of: find.byKey(const Key('secondLetter')),
        matching: find.byType(TextField));
    final clear = find.byType(FloatingActionButton);
    await tester.tap(clear);

    await tester.pumpAndSettle();

    await tester.enterText(txtSecond, 'E');

    await tester.pumpAndSettle();
    final animal = find.text('ANIMAL');
    final capaz = find.text('CAPAZ');
    final melao = find.text('MELAO');
    final fuzil = find.text('FUZIL');
    final funil = find.text('FUNIL');

    expect(txtSecond, findsOneWidget);
    expect(animal, findsNothing);
    expect(capaz, findsNothing);
    expect(melao, findsWidgets);
    expect(fuzil, findsNothing);
    expect(funil, findsNothing);
  });
  testWidgets(
      '''
Dado uma lista de palavras
Quando limpar a tela
E digitado as letras FU_IL
Deve exibir as palavra FUZIL e FUNIL
''',
      (tester) async {
    await tester.pumpWidget(makeTestableWidget(child: const HomePage()));
    await tester.pumpAndSettle();

    final txtFirst = find.descendant(
        of: find.byKey(const Key('firstLetter')),
        matching: find.byType(TextField));
    final txtSecond = find.descendant(
        of: find.byKey(const Key('secondLetter')),
        matching: find.byType(TextField));
    final txtFourth = find.descendant(
        of: find.byKey(const Key('fourthLetter')),
        matching: find.byType(TextField));
    final txtFifth = find.descendant(
        of: find.byKey(const Key('fifthLetter')),
        matching: find.byType(TextField));
    final clear = find.byType(FloatingActionButton);

    await tester.tap(clear);

    await tester.pumpAndSettle();

    await tester.enterText(txtFirst, 'F');
    await tester.enterText(txtSecond, 'U');
    await tester.enterText(txtFourth, 'I');
    await tester.enterText(txtFifth, 'L');

    await tester.pumpAndSettle();
    final animal = find.text('ANIMAL');
    final capaz = find.text('CAPAZ');
    final melao = find.text('MELAO');
    final fuzil = find.text('FUZIL');
    final funil = find.text('FUNIL');

    expect(txtSecond, findsOneWidget);
    expect(animal, findsNothing);
    expect(capaz, findsNothing);
    expect(melao, findsNothing);
    expect(fuzil, findsWidgets);
    expect(funil, findsWidgets);
  });
  testWidgets(
      '''
Dado uma lista de palavras
Quando limpar a tela
E digitado as letras FUZIL
Deve exibir as palavra FUZIL
''',
      (tester) async {
    await tester.pumpWidget(makeTestableWidget(child: const HomePage()));
    await tester.pumpAndSettle();

    final txtFirst = find.descendant(
        of: find.byKey(const Key('firstLetter')),
        matching: find.byType(TextField));
    final txtSecond = find.descendant(
        of: find.byKey(const Key('secondLetter')),
        matching: find.byType(TextField));
    final txtThird = find.descendant(
        of: find.byKey(const Key('thirdLetter')),
        matching: find.byType(TextField));
    final txtFourth = find.descendant(
        of: find.byKey(const Key('fourthLetter')),
        matching: find.byType(TextField));
    final txtFifth = find.descendant(
        of: find.byKey(const Key('fifthLetter')),
        matching: find.byType(TextField));
    final clear = find.byType(FloatingActionButton);

    await tester.tap(clear);

    await tester.pumpAndSettle();

    await tester.enterText(txtFirst, 'F');
    await tester.enterText(txtSecond, 'U');
    await tester.enterText(txtThird, 'Z');
    await tester.enterText(txtFourth, 'I');
    await tester.enterText(txtFifth, 'L');

    await tester.pumpAndSettle();
    final animal = find.text('ANIMAL');
    final capaz = find.text('CAPAZ');
    final melao = find.text('MELAO');
    final fuzil = find.text('FUZIL');
    final funil = find.text('FUNIL');

    expect(txtSecond, findsOneWidget);
    expect(animal, findsNothing);
    expect(capaz, findsNothing);
    expect(melao, findsNothing);
    expect(fuzil, findsWidgets);
    expect(funil, findsNothing);
  });
}
