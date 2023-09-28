import 'package:flutter_modular/flutter_modular.dart';

import '../../app_module.dart';
import 'domain/repositories/word_repository_interface.dart';
import 'domain/usecases/build_plural_word_usecase.dart';
import 'domain/usecases/filter_position_letters_usecase.dart';
import 'domain/usecases/filter_words_usecase.dart';
import 'domain/usecases/search_words_usecase.dart';
import 'infra/data/datasources/word_datasource_interface.dart';
import 'infra/data/repositories/word_repository.dart';
import 'infra/datasource/external/datasources/word_datasource.dart';
import 'presentation/pages/black_list/black_list_controller.dart';
import 'presentation/pages/black_list/black_list_page.dart';
import 'presentation/pages/home/home_controller.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/home/home_store.dart';
import 'presentation/pages/home/widgets/info_dialog/info_dialog_controller.dart';
import 'presentation/pages/letters_position/letter_position_controller.dart';
import 'presentation/pages/letters_position/letter_position_page.dart';
import 'presentation/pages/letters_position/letter_position_store.dart';
import 'presentation/pages/white_list/white_list_controller.dart';
import 'presentation/pages/white_list/white_list_page.dart';
import 'presentation/stores/words_store.dart';

class WordsModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(i) {
    i.addLazySingleton(WordsStore.new);
    i.addLazySingleton(HomeStore.new);
    i.addLazySingleton(LetterPositionStore.new);
    i.add(InfoDialogController.new);
    i.add(FilterPositionLettersUsecase.new);
    i.add(FilterWordsUsecase.new);
    i.add(SearchWordsUsecase.new);
    i.add(BuildPluralWordUsecase.new);
    i.add<IWordRepository>(WordRepository.new);
    i.add<IWordDatasource>(WordDatasource.new);
    i.add(HomeController.new);
    i.add(WhiteListController.new);
    i.add(BlackListController.new);
    i.add(LetterPositionController.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => HomePage(controller: Modular.get()),
    );
    r.child(
      '/whitelist',
      child: (context) => WhiteListPage(controller: Modular.get()),
    );
    r.child('/blacklist',
        child: (context) => BlackListPage(controller: Modular.get()));
    r.child(
      '/position',
      child: (context) => LetterPositiontPage(controller: Modular.get()),
    );
  }
}
