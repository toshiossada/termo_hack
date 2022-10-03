import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:termo/app/commons/adapters/custom_alerts/dialog_adapter.dart';
import 'package:termo/app/modules/words/domain/usecases/filter_position_letters_usecase.dart';
import 'package:termo/app/modules/words/domain/usecases/filter_words_usecase.dart';
import 'package:termo/app/modules/words/domain/usecases/search_words_usecase.dart';
import 'package:termo/app/modules/words/presentation/pages/home/home_controller.dart';
import 'package:termo/app/modules/words/presentation/pages/home/home_store.dart';
import 'package:termo/app/modules/words/presentation/stores/words_store.dart';

import 'home_controller_test.mocks.dart';

@GenerateMocks([
  SearchWordsUsecase,
  FilterWordsUsecase,
  IDialogAdapter,
  IModularNavigator,
  FilterPositionLettersUsecase,
])
void main() {
  var homeStore = HomeStore();
  var wordStore = WordsStore();
  final searchWordsUsecase = MockSearchWordsUsecase();
  final filterWordsUsecase = MockFilterWordsUsecase();
  final filterPositionLettersUsecase = MockFilterPositionLettersUsecase();
  final dialogAdapter = MockIDialogAdapter();
  final navigate = MockIModularNavigator();
  late HomeController controller;

  setUp(() {
    homeStore = HomeStore();
    wordStore = WordsStore();
    controller = HomeController(
      searchWordsUsecase: searchWordsUsecase,
      filterWordsUsecase: filterWordsUsecase,
      dialog: dialogAdapter,
      store: homeStore,
      wordStore: wordStore,
      filterPositionLettersUsecase: filterPositionLettersUsecase,
    );
    Modular.navigatorDelegate = navigate;
  });
  test(
      '''
Dado a inicialização do controller
Quando a api retornar uma lista de palavras
Então o store deve receber as palavras com 5 letras
''',
      () async {
    final words = [
      'amigo',
      'animal',
      'azuis',
    ];

    final resultWords = words.where((element) => element.length == 5).toList();
    when(searchWordsUsecase()).thenAnswer((_) async => words);
    when(filterPositionLettersUsecase(
      wordEntity: anyNamed('wordEntity'),
      words: anyNamed('words'),
    )).thenAnswer((_) => resultWords);
    when(filterWordsUsecase(
      words: words,
      blackList: anyNamed('blackList'),
      whiteList: anyNamed('whiteList'),
      wordEntity: anyNamed('wordEntity'),
    )).thenAnswer((_) => resultWords);
    await controller.init();

    verify(searchWordsUsecase());
    verify(filterWordsUsecase(
      words: words,
      blackList: anyNamed('blackList'),
      whiteList: anyNamed('whiteList'),
      wordEntity: anyNamed('wordEntity'),
    ));
    verify(filterPositionLettersUsecase(
      wordEntity: anyNamed('wordEntity'),
      words: anyNamed('words'),
    ));
    expect(wordStore.value.words, resultWords);
    expect(wordStore.value.loading, false);
  });

  test(
      '''
Dado a a primeira letra estiver setada com A
Quando mudar a primera letra para O
Então a store deve estar com a primeira letra com O
''',
      () {
    when(filterWordsUsecase(
      words: anyNamed('words'),
      blackList: anyNamed('blackList'),
      whiteList: anyNamed('whiteList'),
      wordEntity: anyNamed('wordEntity'),
    )).thenAnswer((_) => []);
    when(filterPositionLettersUsecase(
      wordEntity: anyNamed('wordEntity'),
      words: anyNamed('words'),
    )).thenAnswer((_) => []);
    const first = 'a';
    const second = 'B';
    const third = 'ç';
    const forth = 'd';
    const fifth = 'é';
    controller.changeLetter(first, 1);
    controller.changeLetter(second, 2);
    controller.changeLetter(third, 3);
    controller.changeLetter(forth, 4);
    controller.changeLetter(fifth, 5);
    controller.changeLetter('o', 1);

    expect(wordStore.value.word.firstLetter, 'O');
    expect(wordStore.value.word.secondLetter, 'B');
    expect(wordStore.value.word.thirdLetter, 'C');
    expect(wordStore.value.word.fourthLetter, 'D');
    expect(wordStore.value.word.fifthLetter, 'E');
    verify(filterWordsUsecase(
      words: anyNamed('words'),
      blackList: anyNamed('blackList'),
      whiteList: anyNamed('whiteList'),
      wordEntity: anyNamed('wordEntity'),
    ));
    verify(filterPositionLettersUsecase(
      wordEntity: anyNamed('wordEntity'),
      words: anyNamed('words'),
    ));
  });

  test(
      '''
Dado que todas as letras estão preenchidas
Quando chamar a funçao de limpar
Deve deixar todas as letras vazias
''',
      () async {
    when(filterWordsUsecase(
      words: anyNamed('words'),
      blackList: anyNamed('blackList'),
      whiteList: anyNamed('whiteList'),
      wordEntity: anyNamed('wordEntity'),
    )).thenAnswer((_) => []);
    when(filterPositionLettersUsecase(
      wordEntity: anyNamed('wordEntity'),
      words: anyNamed('words'),
    )).thenAnswer((_) => []);
    controller.changeLetter('a', 1);
    controller.changeLetter('a', 2);
    controller.changeLetter('a', 3);
    controller.changeLetter('a', 4);
    controller.changeLetter('a', 5);
    controller.clear();

    verify(filterWordsUsecase(
      words: anyNamed('words'),
      blackList: anyNamed('blackList'),
      whiteList: anyNamed('whiteList'),
      wordEntity: anyNamed('wordEntity'),
    ));
    verify(filterPositionLettersUsecase(
      wordEntity: anyNamed('wordEntity'),
      words: anyNamed('words'),
    ));
    expect(wordStore.value.word.firstLetter.isEmpty, true);
    expect(wordStore.value.word.secondLetter.isEmpty, true);
    expect(wordStore.value.word.thirdLetter.isEmpty, true);
    expect(wordStore.value.word.fourthLetter.isEmpty, true);
    expect(wordStore.value.word.fifthLetter.isEmpty, true);
  });

  test(
      '''
Dado a inicialização do controller
Quando chamar a funçao showBlacklist
Deve navegar para a rota /blacklist
''',
      () async {
    when(navigate.pushNamed('/blacklist')).thenAnswer((_) async {
      return null;
    });
    when(filterWordsUsecase(
      words: anyNamed('words'),
      blackList: anyNamed('blackList'),
      whiteList: anyNamed('whiteList'),
      wordEntity: anyNamed('wordEntity'),
    )).thenAnswer((_) => []);
    when(filterPositionLettersUsecase(
      wordEntity: anyNamed('wordEntity'),
      words: anyNamed('words'),
    )).thenAnswer((_) => []);

    await controller.showBlacklist();

    verify(navigate.pushNamed('/blacklist'));
    verify(filterWordsUsecase(
      words: anyNamed('words'),
      blackList: anyNamed('blackList'),
      whiteList: anyNamed('whiteList'),
      wordEntity: anyNamed('wordEntity'),
    ));
    verify(filterPositionLettersUsecase(
      wordEntity: anyNamed('wordEntity'),
      words: anyNamed('words'),
    ));
  });

  test(
      '''
Dado a inicialização do controller
Quando chamar a funçao showWhitelist
Deve navegar para a rota /whitelist
''',
      () async {
    when(navigate.pushNamed('/whitelist')).thenAnswer((_) async {
      return null;
    });
    when(filterWordsUsecase(
      words: anyNamed('words'),
      blackList: anyNamed('blackList'),
      whiteList: anyNamed('whiteList'),
      wordEntity: anyNamed('wordEntity'),
    )).thenAnswer((_) => []);
    when(filterPositionLettersUsecase(
      wordEntity: anyNamed('wordEntity'),
      words: anyNamed('words'),
    )).thenAnswer((_) => []);

    await controller.showWhitelist();

    verify(navigate.pushNamed('/whitelist'));
    verify(filterWordsUsecase(
      words: anyNamed('words'),
      blackList: anyNamed('blackList'),
      whiteList: anyNamed('whiteList'),
      wordEntity: anyNamed('wordEntity'),
    ));
    verify(filterPositionLettersUsecase(
      wordEntity: anyNamed('wordEntity'),
      words: anyNamed('words'),
    ));
  });
  test(
      '''
Dado a inicialização do controller
Quando chamar a funçao showInfo
Deve chamar o showDialog do dialogAdapter
''',
      () async {
    when(dialogAdapter.showDialog(any));

    await controller.showInfo();

    verify(dialogAdapter.showDialog(any));
  });
}
