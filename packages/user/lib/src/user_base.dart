import 'dart:convert';
import 'dart:io';

import 'package:user/src/api/user_backend.dart';
import 'package:user/src/api/user_local_storage.dart';
import 'package:user/src/models/remote_user/user.dart';

class UserRepository {
  final Directory cacheDirectory;
  final Stream<String> wsCommunication;
  final UserLocalStorage _cache = UserLocalStorage();

  UserRepository({
    required this.cacheDirectory,
    required this.wsCommunication,
  }) {
    wsCommunication.listen((message) async {
      if (json.decode(message)['event'] == 'refreshUser') {
        final user = User.fromJson(json.decode(message)['data']);
        await _cache.init(cacheDirectory);
        _cache.saveUser(user);
      }
    });
  }

  Future<User> getUser(String userId) async {
    final user = await _cache.getUser(userId);
    if (user != null) return user;
    final newUser = await UserBackend.getUser(userId);
    _cache.saveUser(newUser);
    return newUser;
  }

  Stream<User?> watchUser() => _cache.watchUser();

  Future<bool> clear(String userId) => _cache.deleteUser(userId);
}
