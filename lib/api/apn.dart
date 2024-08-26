import 'dart:convert';
import 'dart:io';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:http2/http2.dart';
import 'package:inoticer/controller/config_controller.dart';
import 'package:inoticer/utils/storage.dart';

Future<String> getToken() async {
  String keyId = 'LH4T9V5U4R';
  String teamId = '5U8LBRXG3A';

  // 检查缓存的token
  final cachedToken = storage.read<String>('apns_token');
  final cachedTimestamp = storage.read<int>('apns_token_timestamp');

  // 如果token存在且未超过30分钟，直接返回缓存的token
  if (cachedToken != null && cachedTimestamp != null) {
    final tokenAge = DateTime.now().millisecondsSinceEpoch - cachedTimestamp;
    if (tokenAge < 1800000) {
      return cachedToken;
    }
  }

  // 加载APNs Auth Key (p8文件) 从 assets
  final String apnsKey = await rootBundle.loadString('assets/key.p8');

  // 生成JWT
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

  // 缓存token和生成时间
  storage.write('apns_token', token);
  storage.write('apns_token_timestamp', DateTime.now().millisecondsSinceEpoch);

  return token;
}

void sendNotification(String title, String body, String icon) async {
  ConfigController configController = Get.find();

  String deviceToken = configController.config['deviceToken'];
  String bundleId = 'me.fin.bark';

  final token = await getToken();

  // 创建HTTP/2客户端
  final client = ClientTransportConnection.viaSocket(
    await SecureSocket.connect('api.push.apple.com', 443,
        supportedProtocols: ['h2']),
  );

  // 构建HTTP/2请求头
  final headers = [
    Header.ascii(':method', 'POST'),
    Header.ascii(':path', '/3/device/$deviceToken'),
    Header.ascii('authorization', 'bearer $token'),
    Header.ascii('content-type', 'application/json'),
    Header.ascii('apns-topic', bundleId),
  ];

  // 推送内容
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
