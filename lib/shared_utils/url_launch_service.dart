import 'dart:io' show Platform;

import 'package:appflug/shared_utils/alert_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:url_launcher/url_launcher.dart';

Future<void> openURL(BuildContext context, {required String url}) async {
  _launchURL(
    context,
    url: url,
    errorMessage: 'Fehler beim Öffnen der Webseite',
  );
}

Future<void> openMail(
  BuildContext context, {
  String? mailReceiverAdress,
  String? mailSubject,
  String? mailBodyText,
  String? errorMessage,
  String? errorType,
}) async {
  String mailtoString = Uri.encodeFull(
    'mailto:$mailReceiverAdress?subject=$mailSubject&body=$mailBodyText',
  );
  _launchURL(context, url: mailtoString, errorMessage: errorMessage);
}

Future<void> openPhone(BuildContext context, {required String number}) async {
  String numberWithoutWhiteSpace = number.replaceAll(RegExp(' '), '');
  String url = 'tel:$numberWithoutWhiteSpace';
  _launchURL(context, url: url, errorMessage: 'Fehler beim Starten des Anrufs');
}

Future<void> openMaps(
  BuildContext context, {
  double? lat,
  double? lng,
  String? address,
}) async {
  final url = Uri.encodeFull(_mapsURL(lat, lng, address));
  _launchURL(context, url: url, errorMessage: 'Fehler beim öffnen von Maps');
}

String _mapsURL(double? lat, double? lng, String? address) {
  const appleMapsURL = 'https://maps.apple.com/';
  const googleMapsURL = 'https://www.google.com/maps/search/?api=1&query=';

  if (lat != null && lng != null && address == null) {
    return Platform.isIOS
        ? '$appleMapsURL?q=$lat,$lng'
        : '$googleMapsURL$lat,$lng';
  } else {
    return Platform.isIOS
        ? '$appleMapsURL?address=$address'
        : '$googleMapsURL$address';
  }
}

Future<void> _launchURL(
  BuildContext context, {
  required String url,
  String? errorMessage,
}) async {
  if (await canLaunch(url) == true) {
    try {
      await launch(
        url,
      );
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print(e);
      return;
    }
  } else {
    AlertService.showSnackBar(
      title: 'Ungültige URL',
      description: 'URL kann nicht geöffnet werden.',
      isSuccess: false,
    );
  }
}
