import 'package:hive/hive.dart';

abstract class HiveManager {
  Box<dynamic>? _box;

  Future<void> initBox(String boxName) async {
    _box = await Hive.openBox(boxName);
  }

  Future<void> writeData(String key, dynamic value) async {
    await _box?.put(key, value);
  }

  dynamic readData(String key) {
    return _box?.get(key);
  }

  Future<void> setUserMetadata(String userId, String bearerToken) async {
    await _box?.put('userId', userId);
    await _box?.put('bearerToken', bearerToken);
  }

  Future<void> writeDataToBox(String box, String key, dynamic value) async {
    final cbox = await Hive.openBox(box);
    cbox.put(key, value);

  }

  static dynamic readDataFromBox(String box, String key) async {
    final cbox = await Hive.openBox(box);
    return cbox.get(key);
  }
}

class UserHiveManager extends HiveManager {
  @override
  Future<void> setUserMetadata(String userId, String bearerToken) async {
    await super.setUserMetadata(userId, bearerToken);
  }

  Future<String> getUserId() async {
    return HiveManager.readDataFromBox("userBox", "userId");
  }
}

class AppDataHiveManager extends HiveManager {
  Future<void> write(String key, dynamic value) async {
    await writeData(key, value);
  }

  dynamic read(String key) {
    return readData(key);
  }
}
