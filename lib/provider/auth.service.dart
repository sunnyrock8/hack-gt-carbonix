import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationService {
  final storage = FlutterSecureStorage();

  Future<void> setUid(String uid) async {
    await storage.write(key: 'user-id', value: uid);
  }

  Future<void> setCompleted(bool completed) async {
    await storage.write(key: 'profile-completed', value: completed ? '1' : '0');
  }

  Future<bool> getProfileCompleted() async {
    return (await storage.read(key: 'profile-completed')) == '1' ? true : false;
  }

  Future<String?> getUid() async {
    String? userId = await storage.read(key: 'user-id');
    return userId;
  }

  Future<void> logout() async {
    await storage.delete(key: 'user-id');
  }
}
