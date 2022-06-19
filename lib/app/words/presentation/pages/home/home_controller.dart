import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../domain/usecases/filter_words_usecase.dart';

import '../../../../commons/adapters/custom_alerts/dialog_adapter_interface.dart';
import '../../../domain/usecases/search_words_usecase.dart';
import '../../stores/words_store.dart';
import 'home_store.dart';
import 'widgets/info_dialog/info_dialog_widget.dart';

class HomeController {
  final txtFirst = TextEditingController();
  final txtSecond = TextEditingController();
  final txtThird = TextEditingController();
  final txtFourth = TextEditingController();
  final txtFifth = TextEditingController();

  final SearchWordsUsecase _searchWordsUsecase;
  final FilterWordsUsecase _filterWordsUsecase;
  final WordsStore wordStore;
  final IDialogAdapter _dialog;
  final HomeStore store;

  HomeController({
    required SearchWordsUsecase searchWordsUsecase,
    required FilterWordsUsecase filterWordsUsecase,
    required IDialogAdapter dialog,
    required this.wordStore,
    required this.store,
  })  : _searchWordsUsecase = searchWordsUsecase,
        _dialog = dialog,
        _filterWordsUsecase = filterWordsUsecase;

  init() async {
    final words = await _searchWordsUsecase();
    store.value = words;
    load();
  }

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
    wordStore.setLoad(load: true);
    try {
      final words = _filterWordsUsecase(
        blackList: wordStore.value.blackList,
        whiteList: wordStore.value.whiteList,
        wordEntity: wordStore.value.word,
        words: store.value,
      );

      wordStore.loadWords(words);
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
