import 'package:url_launcher/url_launcher.dart';

class InfoDialogController {
  final gitHub =
      Uri.parse('https://github.com/toshiossada/termo/blob/main/words.json');
  final email = Uri.parse('mailto:smith@example.org?subject=[Novo%20Termo]');

  openGithub() => launchUrl(gitHub);
  openEmail() => launchUrl(email);
}
