import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'commons/adapters/custom_alerts/asuka/asuka_dialog.dart';
import 'commons/adapters/custom_alerts/dialog_adapter.dart';
import 'commons/adapters/custom_alerts/launch_url/launch_url_adapter.dart';
import 'commons/adapters/http_client/dio/dio_adapter.dart';
import 'commons/adapters/http_client/dio/interceptors/dio_interceptor.dart';
import 'commons/adapters/http_client/http_client_adapter.dart';
import 'words/words_module.dart';
import 'package:asuka/asuka.dart' as asuka;

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<IDialogAdapter>((i) => AsukaDialog(
          fShowDialog: (Widget child) {
            asuka.showDialog(builder: (context) => child);
          },
          fAlert: (String text) {
            asuka.AsukaSnackbar.alert(text).show();
          },
        )),
    Bind.factory((i) => LaunchUrlAdapter()),
    Bind.factory((i) => Dio()),
    Bind.factory<IHttpClientAdapter>((i) => DioAdapter(dio: i(), interceptors: [
          i<CustomInterceptors>(),
        ])),
    Bind.factory<CustomInterceptors>((i) => CustomInterceptors()),
  ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: WordsModule()),
      ];
}
