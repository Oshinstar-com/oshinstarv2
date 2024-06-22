import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    required String userId,
    required String email,
    String? password,
    String? firstName,
    String? lastName,
    String? gender,
    DateTime? birthdate,
    String? phone,
    String? location,
    List<String>? categories,
    bool? isPhoneVerified,
    bool? isEmailVerified,
    required int attempts,
    required bool canUpdatePhoneCode,
    String? accountType,
    List<String>? images,
    List<String>? videos,
    List<String>? tracks,
    List<String>? collections,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
