import 'package:flutter/cupertino.dart';

import '../../../../../commons/adapters/custom_alerts/dialog_adapter.dart';
import '../../../../../commons/extensions/match_letter_extension.dart';
import '../../stores/words_store.dart';
import 'white_list_page.dart';

class WhiteListController extends InheritedNotifier {
  final txtLetter = TextEditingController();
  final WordsStore wordStore;
  final IDialogAdapter dialog;
  final myFocusNode = FocusNode();

  WhiteListController({
    super.key,
    required this.wordStore,
    required this.dialog,
  }) : super(child: const WhiteListPage());

  static WhiteListController of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<WhiteListController>()!;

  remove(String letter) => wordStore.removeWhiteList(letter.formatWord());

  addLetter() {
    if (txtLetter.text.trim().isEmpty) return;
    if (wordStore.value.whiteList.any(
        (element) => element.formatWord() == txtLetter.text.formatWord())) {
      dialog.alertSnackBar('Letra ja esta na whitelist');
      txtLetter.clear();
      myFocusNode.requestFocus();
      return;
    }
    if (txtLetter.text.isNotEmpty) {
      for (var e in txtLetter.text.runes) {
        var character = String.fromCharCode(e).formatWord();
        if (character.isEmpty) return;
        if (wordStore.value.blackList.any((element) => element == character)) {
          dialog.alertSnackBar('Letra $character! ja esta na blackList');
          continue;
        }

        if (!wordStore.value.whiteList.any(
            (element) => element.formatWord() == txtLetter.text.formatWord())) {
          wordStore.addWhiteList(character.formatWord());
        }
      }

      txtLetter.clear();
      myFocusNode.requestFocus();
    }
  }
}
