import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';
import 'package:termo/app/app_module.dart';
import 'package:termo/app/modules/words/presentation/pages/black_list/black_list_controller.dart';
import 'package:termo/app/modules/words/words_module.dart';

import '../../../../../../helpers/make_testable_widget.dart';

void main() {
  setUp(() {
    initModules([
      AppModule(),
      WordsModule(),
    ]);
  });

  testWidgets(
      '''
Dado a abertura da tela de blacklist
Quando o estiver tudo carregado
Entao deve encontrar o botão de adicionar letra
E o campo de texto de letra
''',
      (tester) async {
    await tester.pumpWidget(makeTestableWidget(
        child: BlackListController(
      dialog: Modular.get(),
      wordStore: Modular.get(),
    )));

    await tester.pumpAndSettle();

    final addButton = find.byIcon(Icons.add);
    final txtLetter = find.byType(TextField);

    expect(addButton, findsOneWidget);
    expect(txtLetter, findsOneWidget);
  });

  testWidgets(
      '''
Dado o texto ABC
Quando não houver nenhuma letra adicionada anteriormente
Entao adicionar as letras A, B, C e encontrar na listview
''',
      (tester) async {
    await tester.pumpWidget(makeTestableWidget(
        child: BlackListController(
      dialog: Modular.get(),
      wordStore: Modular.get(),
    )));
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

  testWidgets(
      '''
Dado o texto ABC
Quando não houver nenhuma letra adicionada anteriormente
Entao adicionar as letras A, B, C e encontrar na listview
''',
      (tester) async {
    await tester.pumpWidget(makeTestableWidget(
        child: BlackListController(
      dialog: Modular.get(),
      wordStore: Modular.get(),
    )));
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

  bool predicateFindbytext(final Widget? widget, String text) =>
      widget is Text && widget.data == text;
  testWidgets(
      '''
Dado o texto ABC
Quando as letras ja estiverem na lista
E apertar o botão para remover a letra A
Entao deverá remover a letra A da lisa e não encontrar mais na tela
''',
      (tester) async {
    await tester.pumpWidget(makeTestableWidget(
        child: BlackListController(
      dialog: Modular.get(),
      wordStore: Modular.get(),
    )));
    await tester.pumpAndSettle();

    final txtLetter = find.byType(TextField);

    await tester.enterText(txtLetter, 'ABC');
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.pumpAndSettle();

    final iconButton = find.descendant(
      of: find.byWidgetPredicate(
        (widget) =>
            widget is ListTile && predicateFindbytext(widget.title, 'A'),
      ),
      matching: find.byType(IconButton),
    );
    expect(iconButton, findsOneWidget);
    await tester.tap(iconButton);
    await tester.pumpAndSettle();

    final b = find.text('B');
    final c = find.text('C');

    expect(txtLetter, findsOneWidget);
    expect(find.text('A'), findsNothing);
    expect(b, findsOneWidget);
    expect(c, findsOneWidget);
  });

  testWidgets(
      '''
Dado o texto ABC
Quando tentar adicionar o texto DADA
Entao deverá adicionar a letra D e encontrar na listview
''',
      (tester) async {
    await tester.pumpWidget(makeTestableWidget(
        child: BlackListController(
      dialog: Modular.get(),
      wordStore: Modular.get(),
    )));
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
