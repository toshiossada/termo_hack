import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:termo/app/app_module.dart';
import 'package:termo/app/commons/adapters/http_client/http_client_adapter.dart';
import 'package:termo/app/commons/adapters/http_client/http_response.dart';
import 'package:termo/app/modules/words/presentation/pages/home/home_page.dart';
import 'package:termo/app/modules/words/words_module.dart';

import 'home_page_golden_test.mocks.dart';

@GenerateMocks([IHttpClientAdapter])
void main() {
  final http = MockIHttpClientAdapter();

  final words = [
    'amigo',
    'animal',
    'azul',
    'coronel',
    'bar',
    'capaz',
    'freguês',
    'fuzil',
    'funil',
    'útil',
    'bagagem',
    'viagem',
    'mão',
    'melão',
  ];
  setUpAll(() {
    const MethodChannel channel =
        MethodChannel('plugins.flutter.io/path_provider');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      return './test/cache/home_page_golden_test';
    });
    Modular.bindModule(AppModule());
    Modular.bindModule(WordsModule());
    Modular.replaceInstance<IHttpClientAdapter>(http);
  });


  testGoldens(
      '''
Dado uma lista de palavras
Quando a página é carregada
Deve exibir as palavras com 5 caracteres
''',
      (tester) async {
    final response =
        HttpResponse(statusCode: 200, data: json.encode({'words': words}));
    when(http.get(any)).thenAnswer((_) async => response);
    await loadAppFonts();

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
        Device.tabletPortrait,
        Device.tabletLandscape,
      ])
      ..addScenario(
        name: 'Clean Home',
        widget: HomePage(controller: Modular.get()),
        onCreate: (scenarioWidgetKey) async {
          await tester.pumpAndSettle();
        },
      );
    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'homeStarted');
  });

  testGoldens(
      '''
Dado uma lista de palavras
Quando digitado a letra F na primeira caixa de texto
Deve exibir as palavras FUNIL e FUZIL
''',
      (tester) async {
    final response =
        HttpResponse(statusCode: 200, data: json.encode({'words': words}));
    when(http.get(any)).thenAnswer((_) async => response);
    await loadAppFonts();
    final home = HomePage(controller: Modular.get());

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
        Device.tabletPortrait,
        Device.tabletLandscape,
      ])
      ..addScenario(
        name: 'First Letter F',
        widget: home,
        onCreate: (scenarioWidgetKey) async {
          final txt = find.descendant(
              of: find.byKey(const Key('firstLetter')),
              matching: find.byType(TextField));
          expect(txt.first, findsOneWidget);

          await tester.enterText(txt.first, 'F');
          await tester.pumpAndSettle();
        },
      );
    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'firstLetterF');
  });
}
