import 'package:flutter_modular/flutter_modular.dart';

import 'infra/datasource/external/datasources/word_datasource.dart';
import 'infra/data/datasources/word_datasource_interface.dart';
import 'infra/data/repositories/word_repository.dart';
import 'domain/repositories/word_repository_interface.dart';
import 'domain/usecases/build_plural_word_usecase.dart';
import 'domain/usecases/filter_position_letters_usecase.dart';
import 'domain/usecases/filter_words_usecase.dart';
import 'domain/usecases/search_words_usecase.dart';
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
  List<Bind> get binds => [
        Bind.lazySingleton((i) => WordsStore()),
        Bind.lazySingleton((i) => HomeStore()),
        Bind.lazySingleton((i) => LetterPositionStore()),
        Bind.factory((i) => InfoDialogController(launchUrlAdapter: i())),
        Bind.factory((i) => FilterPositionLettersUsecase()),
        Bind.factory((i) => FilterWordsUsecase()),
        Bind.factory((i) => SearchWordsUsecase(
              wordRepository: i(),
              buildPluralWord: i(),
            )),
        Bind.factory((i) => BuildPluralWordUsecase()),
        Bind.factory<IWordRepository>(
            (i) => WordRepository(wordDataSource: i())),
        Bind.factory<IWordDatasource>((i) => WordDatasource(httpClient: i())),
        Bind.factory((i) => HomeController(
              wordStore: i(),
              searchWordsUsecase: i(),
              dialog: i(),
              store: i(),
              filterWordsUsecase: i(),
              filterPositionLettersUsecase: i(),
            )),
        Bind.factory((i) => WhiteListController(
              wordStore: i(),
              dialog: i(),
            )),
        Bind.factory((i) => BlackListController(
              wordStore: i(),
              dialog: i(),
            )),
        Bind.factory((i) => LetterPositionController(
              wordStore: i(),
              letterPositionStore: i(),
            )),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => HomePage(controller: Modular.get()),
        ),
        ChildRoute(
          '/whitelist',
          child: (_, args) => WhiteListPage(controller: Modular.get()),
        ),
        ChildRoute('/blacklist',
            child: (_, args) => BlackListPage(controller: Modular.get())),
        ChildRoute(
          '/position',
          child: (_, args) => LetterPositiontPage(controller: Modular.get()),
        ),
      ];
}
