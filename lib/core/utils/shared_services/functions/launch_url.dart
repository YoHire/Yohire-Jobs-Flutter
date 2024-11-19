    import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String url) async {
    if (!url.contains('https')) {
      url = 'https://$url';
    }
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }