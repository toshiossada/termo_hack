import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:termo/app/commons/adapters/custom_alerts/launch_url/launch_url_adapter.dart';
import 'package:termo/app/words/presentation/pages/home/widgets/info_dialog/info_dialog_controller.dart';

import 'info_dialog_controller_test.mocks.dart';

@GenerateMocks([LaunchUrlAdapter])
void main() {
  late final InfoDialogController controller;
  final launch = MockLaunchUrlAdapter();

  setUpAll(() {
    controller = InfoDialogController(launchUrlAdapter: launch);
  });
  test('email', () async {
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
  test('github', () async {
    when(launch.openUrl(controller.gitHub)).thenAnswer((_) async => true);
    await controller.openGithub();

    verify(launch.openUrl(controller.gitHub));
  });
}
