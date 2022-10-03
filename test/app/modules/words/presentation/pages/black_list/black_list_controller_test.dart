import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:termo/app/commons/adapters/custom_alerts/dialog_adapter.dart';
import 'package:termo/app/modules/words/presentation/pages/black_list/black_list_controller.dart';
import 'package:termo/app/modules/words/presentation/stores/words_store.dart';

import 'black_list_controller_test.mocks.dart';

@GenerateMocks([IDialogAdapter])
void main() {
  final dialogAdapter = MockIDialogAdapter();
  late WordsStore wordStore;
  late BlackListController controller;

  setUp(() {
    wordStore = WordsStore();
    controller = BlackListController(
      wordStore: wordStore,
      dialog: dialogAdapter,
    );
  });

  group('Add blacklist', () {
    test('''
Dado o texto D,A,D,O
Quando a blacklistfor vazia
E a whitelist for vazia
Então deve adicionar na blacklist as letras DAO
''', () async {
      controller.txtLetter.value = const TextEditingValue(text: 'dado');
      controller.addLetter();

      expect(wordStore.value.blackList.length == 3, true);
      expect(wordStore.value.blackList.any((e) => e == 'D'), true);
      expect(wordStore.value.blackList.any((e) => e == 'A'), true);
      expect(wordStore.value.blackList.any((e) => e == 'O'), true);
    });
    test('''
Dado o texto D,A,D,O
Quando a blacklistfor vazia
E a whitelist for vazia
E a primeira letra da palavra for D
Então deve adicionar na blacklist as letras DAO
''', () async {
      wordStore.changeLetter('D', 1);
      controller.txtLetter.value = const TextEditingValue(text: 'dado');
      controller.addLetter();

      expect(wordStore.value.blackList.length == 2, true);
      expect(wordStore.value.blackList.any((e) => e == 'D'), false);
      expect(wordStore.value.blackList.any((e) => e == 'A'), true);
      expect(wordStore.value.blackList.any((e) => e == 'O'), true);
    });
    test('''
Dado o texto um espaço vazio
Quando a blacklistfor for vazia
E a whitelist for vazia
Então não deve adicionar nada a blacklistfor
E ela deve ser vazia
''', () async {
      controller.txtLetter.value = const TextEditingValue(text: ' ');
      controller.addLetter();

      expect(wordStore.value.blackList.isEmpty, true);
    });

    test('''
Dado o texto A
Quando a blacklistfor possui as letras DAO
E a whitelist for vazia
Então deve nào deve adicionar letra
E deve emitir um alerta uma vez
''', () async {
      when(dialogAdapter.alertSnackBar(any)).thenAnswer((_) {});

      wordStore.addBlackList('D');
      wordStore.addBlackList('A');
      wordStore.addBlackList('O');
      controller.txtLetter.value = const TextEditingValue(text: 'a');

      controller.addLetter();

      verify(dialogAdapter.alertSnackBar(any));
      expect(wordStore.value.blackList.length == 3, true);
      expect(wordStore.value.blackList.any((e) => e == 'D'), true);
      expect(wordStore.value.blackList.any((e) => e == 'A'), true);
      expect(wordStore.value.blackList.any((e) => e == 'O'), true);
    });

    test('''
Dado o texto D,A,D,O
Quando a blacklist for vazia
E a whitelist tiver a letra D
Então deve adicionar na blacklist as letras AO
''', () async {
      when(dialogAdapter.alertSnackBar(any)).thenAnswer((_) {});
      wordStore.addWhiteList('D');
      controller.txtLetter.value = const TextEditingValue(text: 'dado');
      controller.addLetter();

      expect(wordStore.value.blackList.length == 2, true);
      expect(wordStore.value.blackList.any((e) => e == 'D'), false);
      expect(wordStore.value.blackList.any((e) => e == 'A'), true);
      expect(wordStore.value.blackList.any((e) => e == 'O'), true);
    });
  });

  test('''
Dado o texto D,A,D,O
Quando a blacklist for vazia
E a lista de letras na posiçao tiver a letra D
Então deve adicionar na blacklist as letras AO
''', () async {
    when(dialogAdapter.alertSnackBar(any)).thenAnswer((_) {});
    wordStore.addPosition('D', 1);
    controller.txtLetter.value = const TextEditingValue(text: 'dado');
    controller.addLetter();

    expect(wordStore.value.blackList.length == 2, true);
    expect(wordStore.value.blackList.any((e) => e == 'D'), false);
    expect(wordStore.value.blackList.any((e) => e == 'A'), true);
    expect(wordStore.value.blackList.any((e) => e == 'O'), true);
  });

  test('''
Dado a remoçao da letra O
Quando a blacklist possuir as letras DAO
Então deve remover a letra O da lista
E ficar apenas DA
''', () async {
    wordStore.addBlackList('D');
    wordStore.addBlackList('A');
    wordStore.addBlackList('O');

    controller.remove('o');

    expect(wordStore.value.blackList.length == 2, true);
    expect(wordStore.value.blackList.any((e) => e == 'D'), true);
    expect(wordStore.value.blackList.any((e) => e == 'A'), true);
    expect(wordStore.value.blackList.any((e) => e == 'O'), false);
  });
}
