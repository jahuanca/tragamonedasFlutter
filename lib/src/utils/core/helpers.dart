
import 'package:url_launcher/url_launcher.dart';

void sendSMS({
  required String numberPhone,
}) async {
  Uri url = Uri.parse("sms:$numberPhone");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

void callPhone({
  required String numberPhone,
}) async {
  Uri url = Uri.parse("tel:+51$numberPhone");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

void sendEmail({
  required String email,
  required String subject,
  required String body,
}) async {
  Uri url = Uri.parse("mailto:$email?subject=$subject&body=$body");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

void sendWhatsapp({
  required String numberPhone,
  required String message,
}) async {
  Uri url = Uri.parse("whatsapp://send?phone=$numberPhone&amp;text=$message");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}