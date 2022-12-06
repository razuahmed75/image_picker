import 'package:url_launcher/url_launcher.dart';

Future launchUrl(String sms) async {
  if (await canLaunch("sms: $sms")) {
    await launch("sms: $sms");
  } else {
    throw "could not launch $sms";
  }
}
