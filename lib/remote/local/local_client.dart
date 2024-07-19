import 'package:hive_flutter/hive_flutter.dart';

abstract class LocalClient {
  Future<void> saveData(String key, dynamic value);
  Future<void> removeData(String key);
  Future<void> removeAll();
  T readData<T>(String key);
  bool hasData<T>(String key);
}

class LocalClientImpl implements LocalClient {
  final box = Hive.box('myBox');

  @override
  Future<void> saveData(String key, dynamic value) async {
    return await box.put(key, value);
  }

  @override
  Future<void> removeData(String key) async {
    return await box.delete(key);
  }

  @override
  T readData<T>(String key) {
    return box.get(key);
  }

  @override
  bool hasData<T>(String key) {
    return box.containsKey(key);
  }

  @override
  Future<void> removeAll() {
    return box.clear();
  }
}
