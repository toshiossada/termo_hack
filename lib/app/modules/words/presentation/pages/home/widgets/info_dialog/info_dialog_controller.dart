import '../../../../../../../commons/adapters/custom_alerts/launch_url/launch_url_adapter.dart';

class InfoDialogController {
  final LaunchUrlAdapter _launchUrlAdapter;
  final gitHub = 'https://github.com/toshiossada/termo/blob/main/words.json';
  final email = 'toshiossada@toshiossada.dev';

  InfoDialogController({required LaunchUrlAdapter launchUrlAdapter})
      : _launchUrlAdapter = launchUrlAdapter;

  Future<bool> openGithub() => _launchUrlAdapter.openUrl(gitHub);
  Future<bool> openEmail() => _launchUrlAdapter.sendEmail(
        email: email,
        subject: '[Novo%20Termo]',
      );
}
