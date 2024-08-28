import 'dart:convert';
import 'dart:io';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http2/http2.dart';
import 'package:inoticer/utils/prefs.dart';

const keyId = 'LH4T9V5U4R';
const teamId = '5U8LBRXG3A';
const bundleId = 'me.fin.bark';

Future<String> getToken() async {
  //get token from cache
  final cachedToken = await prefs.getString('apns_token');
  final cachedTimestamp = await prefs.getInt('apns_token_timestamp');

  //if token valid, return cached token
  if (cachedToken != null && cachedTimestamp != null) {
    final tokenAge = DateTime.now().millisecondsSinceEpoch - cachedTimestamp;
    if (tokenAge < 1800000) {
      return cachedToken;
    }
  }

  // get APNs Auth Key from assets
  final apnsKey = await rootBundle.loadString('assets/key.p8');

  //generate JWT
  final jwt = JWT(
    {
      'iss': teamId,
      'iat': (DateTime.now().millisecondsSinceEpoch ~/ 1000),
    },
    header: {'kid': keyId},
  );

  final token = jwt.sign(
    ECPrivateKey(apnsKey),
    algorithm: JWTAlgorithm.ES256,
  );

  // cache token
  await prefs.setString('apns_token', token);
  await prefs.setInt(
      'apns_token_timestamp', DateTime.now().millisecondsSinceEpoch);

  return token;
}

void sendNotification(
    String deviceToken, String title, String body, String icon) async {
  final token = await getToken();

  final client = ClientTransportConnection.viaSocket(
    await SecureSocket.connect('api.push.apple.com', 443,
        supportedProtocols: ['h2']),
  );

  final headers = [
    Header.ascii(':method', 'POST'),
    Header.ascii(':path', '/3/device/$deviceToken'),
    Header.ascii('authorization', 'bearer $token'),
    Header.ascii('content-type', 'application/json'),
    Header.ascii('apns-topic', bundleId),
  ];

  final data = jsonEncode({
    'aps': {
      'mutable-content': 1,
      'alert': {
        'title': title,
        'body': body,
      },
      'sound': 'default',
    },
    'icon': icon
  });

  // 发送HTTP/2请求
  final stream = client.makeRequest(headers);
  stream.sendData(utf8.encode(data), endStream: true);

  // 处理响应
  await for (var message in stream.incomingMessages) {
    if (message is HeadersStreamMessage) {
      print('Response headers: ${message.headers}');
    } else if (message is DataStreamMessage) {
      print('Response data: ${utf8.decode(message.bytes)}');
    }
  }

  await client.finish();
}
