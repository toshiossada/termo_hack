import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:modular_test/modular_test.dart';
import 'package:termo/app/app_module.dart';
import 'package:termo/app/commons/adapters/custom_alerts/launch_url/launch_url_adapter.dart';
import 'package:termo/app/modules/words/presentation/pages/home/widgets/info_dialog/info_dialog_widget.dart';
import 'package:termo/app/modules/words/words_module.dart';

import '../../../../../../../../helpers/make_testable_widget.dart';

@GenerateMocks([LaunchUrlAdapter])
void main() {
  setUp(() {
    initModules([
      AppModule(),
      WordsModule(),
    ]);
  });

  testWidgets('''
Dado a abertura da tela
Quando finalizar o carregamento
Deve encontrar na tela os textos 'Abre um PR no github' E
'toshiossada@toshiossada.dev'
''', (tester) async {
    await tester.pumpWidget(makeTestableWidget(
      child: const InfoDialogWidget(),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Abre um PR no github'), findsWidgets);
    expect(find.text('toshiossada@toshiossada.dev'), findsWidgets);
  });

  testWidgets('''
Dado a abertura da tela
Quando clicar no botão de abrir PR
Deve abrir o navegador com o link do github
''', (tester) async {
    await tester.pumpWidget(makeTestableWidget(
      child: const InfoDialogWidget(),
    ));
    await tester.pumpAndSettle();

    tester.tap(find.widgetWithText(InkWell, 'Abre um PR no github'));
  });
  testWidgets('''
Dado a abertura da tela
Quando clicar no botão de enviar emai
Deve abrir o navegador com o link do email
''', (tester) async {
    await tester.pumpWidget(makeTestableWidget(
      child: const InfoDialogWidget(),
    ));
    await tester.pumpAndSettle();

    tester.tap(find.widgetWithText(InkWell, 'toshiossada@toshiossada.dev'));
  });
}
