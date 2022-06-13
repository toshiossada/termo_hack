import 'package:flutter_modular/flutter_modular.dart';
import 'commons/adapters/custom_alerts/asuka/asuka_dialog.dart';
import 'commons/adapters/custom_alerts/dialog_adapter.dart';
import 'commons/adapters/http_client/http/http_adapter.dart';
import 'commons/adapters/http_client/http_client_adapter.dart';
import 'words/words_module.dart';
import 'package:http/http.dart' as http;

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<DialogAdapter>((i) => AsukaDialog()),
    Bind.factory((i) => http.Client()),
    Bind.factory<IHttpClientAdapter>((i) => HttpAdapter(http: i())),
    // Bind.factory((i) => Dio()),
    // Bind.factory<IHttpClientAdapter>((i) => DioAdapter(
    //       dio: i(),
    //       interceptors: [
    //         i<CustomInterceptors>(),
    //       ],
    //     )),
    // Bind.factory<CustomInterceptors>((i) => CustomInterceptors()),
  ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: WordsModule()),
      ];
}
