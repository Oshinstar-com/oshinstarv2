import 'package:hive/hive.dart';


abstract class HiveManager {
  Box<dynamic>? userBox;

  HiveManager() {
    _initHive();
  }

  Future<void> _initHive() async {
    userBox = Hive.box('userBox');
  }

  Future<void> writeData(String key, dynamic value) async {
    await userBox?.put(key, value);
  }

  dynamic readData(String key) {
    return userBox?.get(key);
  }

  Future<void> setUserMetadata(String userId, String bearerToken) async {
    await userBox?.put('userId', userId);
    await userBox?.put('bearerToken', bearerToken);
  }
}

class UserHiveManager extends HiveManager {
  @override
  Future<void> setUserMetadata(String userId, String bearerToken) async {
    await super.setUserMetadata(userId, bearerToken);
  }

  Future<String> getUserId() async {
    return await super.readData("userId");
  }
}
