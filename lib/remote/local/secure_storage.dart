import 'package:eduappui/remote/constant/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  Future<void> saveAccessToken(dynamic value);
  Future<String?> getAccessToken();
  Future<bool> hasToken();
  void removeAll();
  Future<void> removeAllAsync();
}

class SecureStorageImpl implements SecureStorage {
  /// Define secure storage
  final secureStorage = const FlutterSecureStorage();

  @override
  Future<void> saveAccessToken(dynamic value) async {
    return await secureStorage.write(key: Constants.access_token, value: value);
  }

  @override
  Future<String?> getAccessToken() {
    return secureStorage.read(key: Constants.access_token);
  }

  @override
  Future<bool> hasToken() async {
    bool hasToken = await secureStorage.containsKey(key: Constants.access_token);
    return hasToken;
  }

  @override
  void removeAll() async {
    await secureStorage.deleteAll();
  }

  @override
  Future<void> removeAllAsync() async {
    await secureStorage.deleteAll();
  }
}
