
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> sendSMS({
  required String numberPhone,
}) async {
  Uri url = Uri.parse("sms:$numberPhone");
  return await _canUrl(url);
}

Future<bool> callPhone({
  required String numberPhone,
}) async {
  Uri url = Uri.parse("tel:+51$numberPhone");
  return await _canUrl(url);
}

Future<bool> sendEmail({
  required String email,
  required String subject,
  required String body,
}) async {
  Uri url = Uri.parse("mailto:$email?subject=$subject&body=$body");
  return await _canUrl(url);
}

Future<bool> sendWhatsapp({
  required String numberPhone,
  required String message,
}) async {
  Uri url = Uri.parse("whatsapp://send?phone=$numberPhone&amp;text=$message");
  return await _canUrl(url);
}

Future<bool> _canUrl(url) async {
  if (await canLaunchUrl(url)) {
    return await launchUrl(url);
  } else {
    return false;
  }
}

void copyData(String data) {
  Clipboard.setData(ClipboardData(text: data));
}
