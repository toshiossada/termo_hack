import 'package:url_launcher/url_launcher.dart' as launcher;

class LaunchUrlAdapter {
  Future<bool> openUrl(String url) => launcher.launchUrl(Uri.parse(url));
  Future<bool> sendEmail({
    required String email,
    String? subject,
  }) =>
      launcher.launchUrl(Uri.parse(
          'mailto:$email?${subject != null ? 'subject=$subject' : ''}'));
}
