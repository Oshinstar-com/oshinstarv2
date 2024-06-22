// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      userId: json['userId'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      gender: json['gender'] as String?,
      birthdate: json['birthdate'] == null
          ? null
          : DateTime.parse(json['birthdate'] as String),
      phone: json['phone'] as String?,
      location: json['location'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isPhoneVerified: json['isPhoneVerified'] as bool?,
      isEmailVerified: json['isEmailVerified'] as bool?,
      attempts: (json['attempts'] as num).toInt(),
      canUpdatePhoneCode: json['canUpdatePhoneCode'] as bool,
      accountType: json['accountType'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      videos:
          (json['videos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tracks:
          (json['tracks'] as List<dynamic>?)?.map((e) => e as String).toList(),
      collections: (json['collections'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'password': instance.password,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'birthdate': instance.birthdate?.toIso8601String(),
      'phone': instance.phone,
      'location': instance.location,
      'categories': instance.categories,
      'isPhoneVerified': instance.isPhoneVerified,
      'isEmailVerified': instance.isEmailVerified,
      'attempts': instance.attempts,
      'canUpdatePhoneCode': instance.canUpdatePhoneCode,
      'accountType': instance.accountType,
      'images': instance.images,
      'videos': instance.videos,
      'tracks': instance.tracks,
      'collections': instance.collections,
    };
