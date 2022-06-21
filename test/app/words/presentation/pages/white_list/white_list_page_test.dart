import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';
import 'package:termo/app/app_module.dart';
import 'package:termo/app/words/presentation/pages/white_list/white_list_page.dart';
import 'package:termo/app/words/words_module.dart';

import '../../../../../helpers/make_testable_widget.dart';

void main() {
  setUp(() {
    initModules([
      AppModule(),
      WordsModule(),
    ]);
  });

  testWidgets('''
Dado a abertura da tela de whitelist
Quando o estiver tudo carregado
Entao deve encontrar o botão de adicionar letra
E o campo de texto de letra
''', (tester) async {
    await tester.pumpWidget(makeTestableWidget(child: const WhiteListPage()));
    await tester.pumpAndSettle();

    final addButton = find.byIcon(Icons.add);
    final txtLetter = find.byType(TextField);

    expect(addButton, findsOneWidget);
    expect(txtLetter, findsOneWidget);
  });

  testWidgets('''
Dado o texto ABC
Quando não houver nenhuma letra adicionada anteriormente
Entao adicionar as letras A, B, C e encontrar na listview
''', (tester) async {
    await tester.pumpWidget(makeTestableWidget(child: const WhiteListPage()));
    await tester.pumpAndSettle();

    final addButton = find.byIcon(Icons.add);
    final txtLetter = find.byType(TextField);

    await tester.enterText(txtLetter, 'ABC');
    await tester.tap(addButton);
    await tester.pump();
    final a = find.text('A');
    final b = find.text('B');
    final c = find.text('C');

    expect(txtLetter, findsOneWidget);
    expect(addButton, findsOneWidget);
    expect(a, findsOneWidget);
    expect(b, findsOneWidget);
    expect(c, findsOneWidget);
  });

  testWidgets('''
Dado o texto ABC
Quando não houver nenhuma letra adicionada anteriormente
Entao adicionar as letras A, B, C e encontrar na listview
''', (tester) async {
    await tester.pumpWidget(makeTestableWidget(child: const WhiteListPage()));
    await tester.pumpAndSettle();

    final addButton = find.byIcon(Icons.add);
    final txtLetter = find.byType(TextField);

    await tester.enterText(txtLetter, 'ABCA');
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.pump();
    final a = find.text('A');
    final b = find.text('B');
    final c = find.text('C');

    expect(txtLetter, findsOneWidget);
    expect(addButton, findsOneWidget);
    expect(a, findsOneWidget);
    expect(b, findsOneWidget);
    expect(c, findsOneWidget);
  });

  testWidgets('''
Dado o texto ABC
Quando as letras ja estiverem na lista
E apertar o botão para remover a letra A
Entao deverá remover a letra A da lisa e não encontrar mais na tela
''', (tester) async {
    await tester.pumpWidget(makeTestableWidget(child: const WhiteListPage()));
    await tester.pumpAndSettle();

    final txtLetter = find.byType(TextField);

    await tester.enterText(txtLetter, 'ABC');
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.remove).first);
    await tester.pumpAndSettle();

    final b = find.text('B');
    final c = find.text('C');

    expect(txtLetter, findsOneWidget);
    expect(find.text('A'), findsNothing);
    expect(b, findsOneWidget);
    expect(c, findsOneWidget);
  });

  testWidgets('''
Dado o texto ABC
Quando tentar adicionar o texto DADA
Entao deverá adicionar a letra D e encontrar na listview
''', (tester) async {
    await tester.pumpWidget(makeTestableWidget(child: const WhiteListPage()));
    await tester.pumpAndSettle();

    final txtLetter = find.byType(TextField);

    await tester.enterText(txtLetter, 'ABC');
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.pumpAndSettle();

    await tester.enterText(txtLetter, 'DADA');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    final b = find.text('B');
    final c = find.text('C');
    final d = find.text('D');

    expect(txtLetter, findsOneWidget);
    expect(find.text('A'), findsOneWidget);
    expect(b, findsOneWidget);
    expect(c, findsOneWidget);
    expect(d, findsOneWidget);
  });
}
