import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:termo/app/commons/adapters/custom_alerts/launch_url/launch_url_adapter.dart';
import 'package:termo/app/modules/words/presentation/pages/home/widgets/info_dialog/info_dialog_controller.dart';

import 'info_dialog_controller_test.mocks.dart';

@GenerateMocks([LaunchUrlAdapter])
void main() {
  late final InfoDialogController controller;
  final launch = MockLaunchUrlAdapter();

  setUpAll(() {
    controller = InfoDialogController(launchUrlAdapter: launch);
  });
  test('''
Dado a inicializaçao da controller
Quando o usuario solicitar a abertura do link de email
Então deve abrir chamar a funçao openEmail do launch
''', () async {
    when(launch.sendEmail(
      email: controller.email,
      subject: anyNamed('subject'),
    )).thenAnswer((_) async => true);
    await controller.openEmail();

    verify(launch.sendEmail(
      email: controller.email,
      subject: anyNamed('subject'),
    ));
  });
  test('''
Dado a inicializaçao da controller
Quando o usuario solicitar a abertura do link de Github
Então deve abrir chamar a funçao openUrl do launch
''', () async {
    when(launch.openUrl(controller.gitHub)).thenAnswer((_) async => true);
    await controller.openGithub();

    verify(launch.openUrl(controller.gitHub));
  });
}
