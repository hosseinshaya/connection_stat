import 'dart:convert';

import 'package:connection_stat/check_vpn_connection.dart';
import 'package:dio/dio.dart';

Future<String> getFullStat({
  required bool countryCode,
  required bool flag,
  required bool publicIp,
  required bool regionName,
  required bool isp,
  required bool vpn,
}) async {
  String publicIpString = await getPublicIp();
  dynamic rawResponse =
      await Dio().get('http://ip-api.com/json/$publicIpString');
  Map<String, dynamic> response = json.decode(rawResponse.toString());
  List<String> textList = [];
  if (countryCode) textList.add(response['countryCode']);
  if (flag) textList.add(getFlag(countryCode: response['countryCode']));
  if (publicIp) textList.add(publicIpString);
  if (regionName) textList.add(response['regionName']);
  if (isp) textList.add(response['isp']);
  if (vpn && await CheckVpnConnection.isVpnActive()) textList.add('🔒');
  return textList.join(' ');
}

Future<String> getPublicIp() async {
  dynamic response = await Dio().get('https://ident.me');
  return response.toString();
}

String getFlag({required String countryCode}) =>
    countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
