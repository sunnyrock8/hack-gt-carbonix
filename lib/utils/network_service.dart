import 'dart:convert';
import 'dart:io';
import 'package:carbonix/provider/auth.service.dart';
import 'package:carbonix/utils/api_paths.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';

typedef OnSuccessCallback = void Function(Map<String, dynamic> data);
typedef OnFailureCallback = void Function(dynamic error);
typedef OnProcessingCallback = void Function();

class NetworkService {
  final String platform = Platform.isAndroid ? "android" : "ios";
  static final NetworkService _singleton = NetworkService._internal();

  factory NetworkService() {
    return _singleton;
  }

  NetworkService._internal();

  Future<void> get(
    APIPath endpoint,
    OnSuccessCallback onSuccess,
    OnFailureCallback onFailure,
    OnProcessingCallback onProcessing, {
    Map<String, String>? headers,
    int maxRetries = 30,
  }) async {
    onProcessing();
    headers ??= <String, String>{};
    headers['User-Id'] =
        (await AuthenticationService().getUid()) ?? "anonymous_user";
    headers['Platform'] = platform;

    for (var retry = 0; retry < maxRetries; retry++) {
      try {
        final response = await http.get(
          Uri.parse(APIPathHelper.getValue(endpoint)),
          headers: headers,
        );
        if (response.statusCode == 200) {
          onSuccess(_returnResponse(response));
          return;
        } else {
          onFailure(_returnResponse(response));
          return;
        }
      } on SocketException {
        await Future.delayed(const Duration(seconds: 3));
      } on ClientException {
        await Future.delayed(const Duration(seconds: 3));
      }
    }
  }

  Future<void> post(
    APIPath endpoint,
    dynamic data,
    OnSuccessCallback onSuccess,
    OnFailureCallback onFailure,
    OnProcessingCallback onProcessing,
  ) async {
    print('4');
    onProcessing();
    for (var retry = 0; retry < 30; retry++) {
      try {
        final response = await http.post(
          Uri.parse(APIPathHelper.getValue(endpoint)),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'User-Id':
                (await AuthenticationService().getUid()) ?? "anonymous_user",
            'Platform': platform,
          },
          body: json.encode(data),
        );
        if (response.statusCode == 200) {
          onSuccess(_returnResponse(response));
          return;
        } else {
          onFailure(_returnResponse(response));
          return;
        }
      } on SocketException {
        await Future.delayed(const Duration(milliseconds: 800));
      }
    }
  }

  Map<String, dynamic> _returnResponse(http.Response response) {
    var body = {};
    if (response.body.isNotEmpty) {
      try {
        body = json.decode(response.body.toString());
      } catch (e) {}
    }
    return {
      "status": response.statusCode,
      "body": body,
    };
  }
}
