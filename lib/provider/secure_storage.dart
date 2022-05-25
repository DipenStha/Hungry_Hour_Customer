import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();
  setToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  Future<String> getToken() async {
    String? value = await storage.read(key: "token");
    print(value);
    return value ?? "";
  }
}
