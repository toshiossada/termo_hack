import 'package:asuka/asuka.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'commons/adapters/cache_adapter/cache_adapter.dart';
import 'commons/adapters/cache_adapter/cache_hive/cache_hive.dart';
import 'commons/adapters/custom_alerts/asuka/asuka_dialog.dart';
import 'commons/adapters/custom_alerts/dialog_adapter.dart';
import 'commons/adapters/custom_alerts/launch_url/launch_url_adapter.dart';
import 'commons/adapters/http_client/dio/dio_adapter.dart';
import 'commons/adapters/http_client/dio/interceptors/dio_interceptor.dart';
import 'commons/adapters/http_client/http_client_adapter.dart';
import 'commons/domain/usecases/check_internet.dart';
import 'modules/words/words_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addInstance(Dio());
    i.add<ICacheAdapter>(CacheHive.new);
    i.add(CheckInternetUsecase.new);
    i.add<CustomInterceptorsAdapter>(CustomInterceptorsAdapter.new);
    i.addInstance<FShowDialog>((Widget child) {
      Asuka.showDialog(builder: (context) => child);
    });
    i.addInstance<FAlert>((String text) {
      AsukaSnackbar.alert(text).show();
    });

    i.addInstance<IDialogAdapter>(AsukaDialog(
      fAlert: i.get<FAlert>(),
      fShowDialog: i.get<FShowDialog>(),
    ));
    i.add(LaunchUrlAdapter.new);
    i.addInstance<IHttpClientAdapter>(DioAdapter(
      dio: i.get<Dio>(),
      interceptors: [i.get<CustomInterceptorsAdapter>()],
    ));
  }

  @override
  void routes(r) {
    r.module('/', module: WordsModule());
  }
}
