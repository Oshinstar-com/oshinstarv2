import 'dart:io';

import 'package:user/src/models/local_user/local_user.dart';
import 'package:user/src/models/remote_user/user.dart';
import 'package:isar/isar.dart';

class UserLocalStorage {
  late Isar isar;

  UserLocalStorage();

  Future<void> init(Directory dir) async {
    isar = await Isar.open(
      [LocalUserSchema],
      directory: dir.path,
    );
  }

  Future<User?> getUser(String userId) async {
    final localUser = await isar.localUsers.getByUserId(userId);
    return localUser != null ? User.fromJson(localUser.toJson()) : null;
  }

  // Stream<User?> watchUser() {
  dynamic watchUser() {
    // final user = isar.localUsers.filter().birthdateEqualTo(value);
    // final queryChanged = user.watch(fireImmediately: true);
    // return queryChanged.map((user) {
    //   return user.isNotEmpty ? User.fromJson(user[0].toJson()) : null;
    // });
  }

  Future<void> saveUser(User user) async {
    final localUser = LocalUser.fromJson(user.toJson());
    await isar.localUsers.put(localUser);
  }

  Future<bool> deleteUser(String userId) async {
    return await isar.localUsers.deleteByUserId(userId);
  }
}
