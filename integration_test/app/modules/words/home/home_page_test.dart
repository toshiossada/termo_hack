import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:termo/main.dart' as app;
import 'package:mockito/annotations.dart';
import 'package:termo/app/commons/adapters/http_client/http_client_adapter.dart';

@GenerateMocks([IHttpClientAdapter, IModularNavigator])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized;

  testWidgets('''
Dado uma lista de palavras
Quando a página é carregada
Deve exibir as palavras com 5 caracteres
''', (tester) async {
    app.main();
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

    expect(txtFirst, findsOneWidget);
    expect(txtSecond, findsOneWidget);
    expect(txtThird, findsOneWidget);
    expect(txtFourth, findsOneWidget);
    expect(txtFifth, findsOneWidget);
  });

  testWidgets('''
Dado uma lista de palavras
Quando limpar a tela
E digitado as letras FU_IL
Deve exibir as palavra FUZIL e FUNIL
''', (tester) async {
    app.main();
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
  testWidgets('''
Dado uma lista de palavras
Quando limpar a tela
E digitado as letras FUZIL
Deve exibir as palavra FUZIL
''', (tester) async {
    app.main();
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
    expect(txtSecond, findsOneWidget);
    expect(animal, findsNothing);
    expect(capaz, findsNothing);
    expect(melao, findsNothing);
    expect(fuzil, findsWidgets);
    expect(funil, findsNothing);
  });
}
