import 'package:carbonix/provider/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthModel extends ChangeNotifier {
  bool _authenticated = false;
  final AuthenticationService _authenticationService = AuthenticationService();
  String? userId;

  void init() async {
    userId = await _authenticationService.getUid();
    _authenticated = userId != null;
  }
}
