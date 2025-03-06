import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:termo/app/commons/adapters/custom_alerts/dialog_adapter.dart';
import 'package:termo/app/modules/words/domain/usecases/filter_position_letters_usecase.dart';
import 'package:termo/app/modules/words/domain/usecases/filter_words_usecase.dart';
import 'package:termo/app/modules/words/domain/usecases/search_words_usecase.dart';
import 'package:termo/app/modules/words/presentation/pages/home/home_controller.dart';
import 'package:termo/app/modules/words/presentation/pages/home/home_page.dart';
import 'package:termo/app/modules/words/presentation/pages/home/home_store.dart';
import 'package:termo/app/modules/words/presentation/stores/words_store.dart';

import '../../../../../../helpers/font_loader.dart';
import '../../../../../../helpers/make_testable_widget.dart';
import 'home_page_golden_test.mocks.dart';

@GenerateMocks([IDialogAdapter, SearchWordsUsecase])
void main() {
  final searchWordsUsecase = MockSearchWordsUsecase();
  final dialogAdapter = MockIDialogAdapter();
  late final HomeController controller;
  final homeStore = HomeStore();
  final filterPositionLettersUsecase = FilterPositionLettersUsecase();
  final wordStore = WordsStore();
  final filterWordsUsecase = FilterWordsUsecase();

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
  setUpAll(() {
    controller = HomeController(
      searchWordsUsecase: searchWordsUsecase,
      filterWordsUsecase: filterWordsUsecase,
      dialog: dialogAdapter,
      store: homeStore,
      wordStore: wordStore,
      filterPositionLettersUsecase: filterPositionLettersUsecase,
    );
  });

  testWidgets(
    'Dado uma lista de palavras '
    'Quando a página é carregada '
    'Deve exibir as palavras com 5 caracteres ',
    tags: 'golden',
    (tester) async {
      loadFonts();
      when(searchWordsUsecase.call()).thenAnswer((_) async => words);

      final home = HomePage(controller: controller);
      await tester.pumpWidget(
        makeTestableWidget(child: MaterialApp(home: home)),
      );

      await expectLater(
        find.byType(HomePage),
        matchesGoldenFile('golden/default_homepage.png'),
      );
    },
  );

  testWidgets(
      'Dado uma lista de palavras '
      'Quando digitado a letra F na primeira caixa de texto '
      'Deve exibir as palavras FUNIL e FUZIL ',
      tags: 'golden', (tester) async {
    FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))
      ..load();
    FontLoader('Roboto')
      ..addFont(rootBundle.load('assets/fonts/Roboto-Regular.ttf'))
      ..load();
    when(searchWordsUsecase.call()).thenAnswer((_) async => words);
    final home = HomePage(controller: controller);

    await tester.pumpWidget(
      makeTestableWidget(child: MaterialApp(home: home)),
    );
    final txt = find.descendant(
        of: find.byKey(const Key('firstLetter')),
        matching: find.byType(TextField));
    expect(txt.first, findsOneWidget);

    await tester.enterText(txt.first, 'F');
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(HomePage),
      matchesGoldenFile('golden/first_letter_F.png', version: 2),
    );
  });
}
