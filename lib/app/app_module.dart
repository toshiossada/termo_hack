import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'commons/adapters/custom_alerts/asuka/asuka_dialog.dart';
import 'commons/adapters/custom_alerts/dialog_adapter_interface.dart';
import 'commons/adapters/http_client/dio/dio_adapter.dart';
import 'commons/adapters/http_client/dio/interceptors/dio_interceptor.dart';
import 'commons/adapters/http_client/http_client_adapter.dart';
import 'words/words_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<IDialogAdapter>((i) => AsukaDialog()),
    Bind.factory((i) => Dio()),
    Bind.factory<IHttpClientAdapter>((i) => DioAdapter(
          dio: i(),
          interceptors: [
            i<CustomInterceptors>(),
          ],
        )),
    Bind.factory<CustomInterceptors>((i) => CustomInterceptors()),
  ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: WordsModule()),
      ];
}
