import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:termo/app/commons/adapters/custom_alerts/dialog_adapter.dart';
import 'package:termo/app/words/domain/usecases/filter_words_usecase.dart';
import 'package:termo/app/words/domain/usecases/search_words_usecase.dart';
import 'package:termo/app/words/presentation/pages/home/home_controller.dart';
import 'package:termo/app/words/presentation/pages/home/home_store.dart';
import 'package:termo/app/words/presentation/stores/words_store.dart';
import 'home_controller_test.mocks.dart';

@GenerateMocks(
    [SearchWordsUsecase, FilterWordsUsecase, IDialogAdapter, IModularNavigator])
void main() {
  var homeStore = HomeStore();
  var wordStore = WordsStore();
  final searchWordsUsecase = MockSearchWordsUsecase();
  final filterWordsUsecase = MockFilterWordsUsecase();
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
    when(searchWordsUsecase()).thenAnswer((_) async => words);
    when(filterWordsUsecase(
      words: words,
      blackList: anyNamed('blackList'),
      whiteList: anyNamed('whiteList'),
      wordEntity: anyNamed('wordEntity'),
    )).thenAnswer(
        (_) => words.where((element) => element.length == 5).toList());
    await controller.init();

    verify(searchWordsUsecase());
    verify(filterWordsUsecase(
      words: words,
      blackList: anyNamed('blackList'),
      whiteList: anyNamed('whiteList'),
      wordEntity: anyNamed('wordEntity'),
    ));
    expect(wordStore.value.words,
        words.where((element) => element.length == 5).toList());
    expect(wordStore.value.loading, false);
  });

  test('''
''', () {
    when(filterWordsUsecase(
      words: anyNamed('words'),
      blackList: anyNamed('blackList'),
      whiteList: anyNamed('whiteList'),
      wordEntity: anyNamed('wordEntity'),
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
  });

  test('''

''', () async {
    when(filterWordsUsecase(
      words: anyNamed('words'),
      blackList: anyNamed('blackList'),
      whiteList: anyNamed('whiteList'),
      wordEntity: anyNamed('wordEntity'),
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
    expect(wordStore.value.word.firstLetter.isEmpty, true);
    expect(wordStore.value.word.secondLetter.isEmpty, true);
    expect(wordStore.value.word.thirdLetter.isEmpty, true);
    expect(wordStore.value.word.fourthLetter.isEmpty, true);
    expect(wordStore.value.word.fifthLetter.isEmpty, true);
  });

  test('''

''', () async {
    when(navigate.pushNamed('/blacklist')).thenAnswer((_) async {
      return null;
    });
    when(filterWordsUsecase(
      words: anyNamed('words'),
      blackList: anyNamed('blackList'),
      whiteList: anyNamed('whiteList'),
      wordEntity: anyNamed('wordEntity'),
    )).thenAnswer((_) => []);

    await controller.showBlacklist();

    verify(navigate.pushNamed('/blacklist'));
    verify(filterWordsUsecase(
      words: anyNamed('words'),
      blackList: anyNamed('blackList'),
      whiteList: anyNamed('whiteList'),
      wordEntity: anyNamed('wordEntity'),
    ));
  });

  test('''

''', () async {
    when(navigate.pushNamed('/whitelist')).thenAnswer((_) async {
      return null;
    });
    when(filterWordsUsecase(
      words: anyNamed('words'),
      blackList: anyNamed('blackList'),
      whiteList: anyNamed('whiteList'),
      wordEntity: anyNamed('wordEntity'),
    )).thenAnswer((_) => []);

    await controller.showWhitelist();

    verify(navigate.pushNamed('/whitelist'));
    verify(filterWordsUsecase(
      words: anyNamed('words'),
      blackList: anyNamed('blackList'),
      whiteList: anyNamed('whiteList'),
      wordEntity: anyNamed('wordEntity'),
    ));
  });
  test('''

''', () async {
    when(navigate.pushNamed('/whitelist')).thenAnswer((_) async {
      return null;
    });
    when(dialogAdapter.showDialog(any));

    await controller.showInfo();

    verify(dialogAdapter.showDialog(any));
  });
}
