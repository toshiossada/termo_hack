import 'package:flutter_modular/flutter_modular.dart';
import 'data/external/datasources/word_datasource.dart';
import 'data/infra/datasources/word_datasource_interface.dart';
import 'domain/usecases/build_plural_word_usecase.dart';
import 'domain/usecases/filter_words_usecase.dart';
import 'presentation/pages/black_list/black_list_controller.dart';
import 'data/infra/repositories/word_repository.dart';
import 'domain/repositories/word_repository_interface.dart';
import 'domain/usecases/search_words_usecase.dart';
import 'presentation/pages/black_list/black_list_page.dart';
import 'presentation/pages/home/home_controller.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/home/home_store.dart';
import 'presentation/pages/home/widgets/info_dialog/info_dialog_controller.dart';
import 'presentation/pages/white_list/white_list_controller.dart';
import 'presentation/pages/white_list/white_list_page.dart';
import 'presentation/stores/words_store.dart';

class WordsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => WordsStore()),
        Bind.lazySingleton((i) => HomeStore()),
        Bind.factory((i) => InfoDialogController()),
        Bind.factory((i) => HomeController(
              wordStore: i(),
              searchWordsUsecase: i(),
              dialog: i(),
              store: i(),
              filterWordsUsecase: i(),
            )),
        Bind.factory((i) => FilterWordsUsecase()),
        Bind.factory((i) => WhiteListController(wordStore: i())),
        Bind.factory((i) => BlackListController(wordStore: i())),
        Bind.factory((i) => SearchWordsUsecase(
              wordRepository: i(),
              buildPluralWord: i(),
            )),
        Bind.factory((i) => BuildPluralWordUsecase()),
        Bind.factory<IWordRepository>(
            (i) => WordRepository(wordDataSource: i())),
        Bind.factory<IWordDataSource>((i) => WordDatasource(httpClient: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const HomePage()),
        ChildRoute('/whitelist', child: (_, args) => const WhiteListPage()),
        ChildRoute('/blacklist', child: (_, args) => const BlacListPage()),
      ];
}
