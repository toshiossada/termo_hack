import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../commons/adapters/custom_alerts/dialog_adapter.dart';
import '../../../domain/usecases/search_words_usecase.dart';
import '../../stores/words_store.dart';
import 'widgets/info_dialog/info_dialog_widget.dart';

class HomeController {
  final txtFirst = TextEditingController();
  final txtSecond = TextEditingController();
  final txtThird = TextEditingController();
  final txtFourth = TextEditingController();
  final txtFifth = TextEditingController();

  final SearchWordsUsecase _searchWordsUsecase;
  final WordsStore wordStore;
  final DialogAdapter _dialog;

  HomeController({
    required SearchWordsUsecase searchWordsUsecase,
    required DialogAdapter dialog,
    required this.wordStore,
  })  : _searchWordsUsecase = searchWordsUsecase,
        _dialog = dialog;

  showWhitelist() async {
    await Modular.to.pushNamed('/whitelist');
    load();
  }

  showBlacklist() async {
    await Modular.to.pushNamed('/blacklist');
    load();
  }

  clear() {
    txtFirst.clear();
    txtSecond.clear();
    txtThird.clear();
    txtFourth.clear();
    txtFifth.clear();
    wordStore.clear();
    load();
  }

  load() async {
    print('load');

    wordStore.setLoad(load: true);
    try {
      final words = await _searchWordsUsecase(
        blackList: wordStore.value.blackList,
        whiteList: wordStore.value.whiteList,
        wordEntity: wordStore.value.word,
      );

      wordStore.loadWords(words);
    } catch (e) {
      print(e);
    } finally {
      wordStore.setLoad(load: false);
    }
  }

  changeLetter(String? letter, int position) {
    wordStore.changeLetter(letter ?? '', position);
    load();
  }

  showInfo() {
    _dialog.showDialog(const InfoDialogWidget());
  }
}
