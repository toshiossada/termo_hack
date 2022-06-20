import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:termo/app/commons/adapters/custom_alerts/dialog_adapter.dart';
import 'package:termo/app/words/presentation/pages/white_list/white_list_controller.dart';
import 'package:termo/app/words/presentation/stores/words_store.dart';

import 'white_list_controller_test.mocks.dart';

@GenerateMocks([IDialogAdapter])
void main() {
  final dialogAdapter = MockIDialogAdapter();
  late WordsStore wordStore;
  late WhiteListController controller;

  setUp(() {
    wordStore = WordsStore();
    controller = WhiteListController(
      wordStore: wordStore,
      dialog: dialogAdapter,
    );
  });

  group('Add whitelist', () {
    test(
        '''
Dado o texto D,A,D,O
Quando a whitelist for vazia
E blacklist for vazia
Então deve adicionar na whitelist as letras DAO
''',
        () async {
      controller.txtLetter.value = const TextEditingValue(text: 'dado');
      controller.addLetter();

      expect(wordStore.value.whiteList.length == 3, true);
      expect(wordStore.value.whiteList.any((e) => e == 'D'), true);
      expect(wordStore.value.whiteList.any((e) => e == 'A'), true);
      expect(wordStore.value.whiteList.any((e) => e == 'O'), true);
    });
    test(
        '''
Dado o texto um espaço vazio
Quando a whitelist for vazia
E blacklist for vazia
Então não deve adicionar nada a whitelist
E ela deve ser vazia
''',
        () async {
      controller.txtLetter.value = const TextEditingValue(text: ' ');
      controller.addLetter();

      expect(wordStore.value.whiteList.isEmpty, true);
    });

    test(
        '''
Dado o texto A
Quando a whitelist possui as letras DAO
E blacklist for vazia
Então deve nào deve adicionar letra
E deve emitir um alerta uma vez
''',
        () async {
      when(dialogAdapter.alertSnackBar(any)).thenAnswer((_) {});

      wordStore.addWhiteList('D');
      wordStore.addWhiteList('A');
      wordStore.addWhiteList('O');
      controller.txtLetter.value = const TextEditingValue(text: 'a');

      controller.addLetter();

      verify(dialogAdapter.alertSnackBar(any));
      expect(wordStore.value.whiteList.length == 3, true);
      expect(wordStore.value.whiteList.any((e) => e == 'D'), true);
      expect(wordStore.value.whiteList.any((e) => e == 'A'), true);
      expect(wordStore.value.whiteList.any((e) => e == 'O'), true);
    });

    test(
        '''
Dado o texto D,A,D,O
Quando a whitelist for vazia
E blacklist tiver a letra D
Então deve adicionar na whitelist as letras AO
E deve emitir um alerta duas vezes
''',
        () async {
      when(dialogAdapter.alertSnackBar(any)).thenAnswer((_) {});
      wordStore.addBlackList('D');
      controller.txtLetter.value = const TextEditingValue(text: 'dado');
      controller.addLetter();

      expect(wordStore.value.whiteList.length == 2, true);
      verify(dialogAdapter.alertSnackBar(any)).called(2);
      expect(wordStore.value.whiteList.any((e) => e == 'D'), false);
      expect(wordStore.value.whiteList.any((e) => e == 'A'), true);
      expect(wordStore.value.whiteList.any((e) => e == 'O'), true);
    });
  });

  test(
      '''
Dado a remoçao da letra O
Quando a whitelist possuir as letras DAO
Então deve remover a letra O da lista
E ficar apenas DA
''',
      () async {
    wordStore.addWhiteList('D');
    wordStore.addWhiteList('A');
    wordStore.addWhiteList('O');

    controller.remove('o');

    expect(wordStore.value.whiteList.length == 2, true);
    expect(wordStore.value.whiteList.any((e) => e == 'D'), true);
    expect(wordStore.value.whiteList.any((e) => e == 'A'), true);
    expect(wordStore.value.whiteList.any((e) => e == 'O'), false);
  });
}
