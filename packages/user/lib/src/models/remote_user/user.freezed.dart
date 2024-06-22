// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get userId => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  DateTime? get birthdate => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  List<String>? get categories => throw _privateConstructorUsedError;
  bool? get isPhoneVerified => throw _privateConstructorUsedError;
  bool? get isEmailVerified => throw _privateConstructorUsedError;
  int get attempts => throw _privateConstructorUsedError;
  bool get canUpdatePhoneCode => throw _privateConstructorUsedError;
  String? get accountType => throw _privateConstructorUsedError;
  List<String>? get images => throw _privateConstructorUsedError;
  List<String>? get videos => throw _privateConstructorUsedError;
  List<String>? get tracks => throw _privateConstructorUsedError;
  List<String>? get collections => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String userId,
      String email,
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
      int attempts,
      bool canUpdatePhoneCode,
      String? accountType,
      List<String>? images,
      List<String>? videos,
      List<String>? tracks,
      List<String>? collections});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? email = null,
    Object? password = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? gender = freezed,
    Object? birthdate = freezed,
    Object? phone = freezed,
    Object? location = freezed,
    Object? categories = freezed,
    Object? isPhoneVerified = freezed,
    Object? isEmailVerified = freezed,
    Object? attempts = null,
    Object? canUpdatePhoneCode = null,
    Object? accountType = freezed,
    Object? images = freezed,
    Object? videos = freezed,
    Object? tracks = freezed,
    Object? collections = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      birthdate: freezed == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      categories: freezed == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isPhoneVerified: freezed == isPhoneVerified
          ? _value.isPhoneVerified
          : isPhoneVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      isEmailVerified: freezed == isEmailVerified
          ? _value.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      attempts: null == attempts
          ? _value.attempts
          : attempts // ignore: cast_nullable_to_non_nullable
              as int,
      canUpdatePhoneCode: null == canUpdatePhoneCode
          ? _value.canUpdatePhoneCode
          : canUpdatePhoneCode // ignore: cast_nullable_to_non_nullable
              as bool,
      accountType: freezed == accountType
          ? _value.accountType
          : accountType // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      videos: freezed == videos
          ? _value.videos
          : videos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      tracks: freezed == tracks
          ? _value.tracks
          : tracks // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      collections: freezed == collections
          ? _value.collections
          : collections // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String email,
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
      int attempts,
      bool canUpdatePhoneCode,
      String? accountType,
      List<String>? images,
      List<String>? videos,
      List<String>? tracks,
      List<String>? collections});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? email = null,
    Object? password = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? gender = freezed,
    Object? birthdate = freezed,
    Object? phone = freezed,
    Object? location = freezed,
    Object? categories = freezed,
    Object? isPhoneVerified = freezed,
    Object? isEmailVerified = freezed,
    Object? attempts = null,
    Object? canUpdatePhoneCode = null,
    Object? accountType = freezed,
    Object? images = freezed,
    Object? videos = freezed,
    Object? tracks = freezed,
    Object? collections = freezed,
  }) {
    return _then(_$UserImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      birthdate: freezed == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      categories: freezed == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isPhoneVerified: freezed == isPhoneVerified
          ? _value.isPhoneVerified
          : isPhoneVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      isEmailVerified: freezed == isEmailVerified
          ? _value.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      attempts: null == attempts
          ? _value.attempts
          : attempts // ignore: cast_nullable_to_non_nullable
              as int,
      canUpdatePhoneCode: null == canUpdatePhoneCode
          ? _value.canUpdatePhoneCode
          : canUpdatePhoneCode // ignore: cast_nullable_to_non_nullable
              as bool,
      accountType: freezed == accountType
          ? _value.accountType
          : accountType // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      videos: freezed == videos
          ? _value._videos
          : videos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      tracks: freezed == tracks
          ? _value._tracks
          : tracks // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      collections: freezed == collections
          ? _value._collections
          : collections // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  _$UserImpl(
      {required this.userId,
      required this.email,
      this.password,
      this.firstName,
      this.lastName,
      this.gender,
      this.birthdate,
      this.phone,
      this.location,
      final List<String>? categories,
      this.isPhoneVerified,
      this.isEmailVerified,
      required this.attempts,
      required this.canUpdatePhoneCode,
      this.accountType,
      final List<String>? images,
      final List<String>? videos,
      final List<String>? tracks,
      final List<String>? collections})
      : _categories = categories,
        _images = images,
        _videos = videos,
        _tracks = tracks,
        _collections = collections;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String userId;
  @override
  final String email;
  @override
  final String? password;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? gender;
  @override
  final DateTime? birthdate;
  @override
  final String? phone;
  @override
  final String? location;
  final List<String>? _categories;
  @override
  List<String>? get categories {
    final value = _categories;
    if (value == null) return null;
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? isPhoneVerified;
  @override
  final bool? isEmailVerified;
  @override
  final int attempts;
  @override
  final bool canUpdatePhoneCode;
  @override
  final String? accountType;
  final List<String>? _images;
  @override
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _videos;
  @override
  List<String>? get videos {
    final value = _videos;
    if (value == null) return null;
    if (_videos is EqualUnmodifiableListView) return _videos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _tracks;
  @override
  List<String>? get tracks {
    final value = _tracks;
    if (value == null) return null;
    if (_tracks is EqualUnmodifiableListView) return _tracks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _collections;
  @override
  List<String>? get collections {
    final value = _collections;
    if (value == null) return null;
    if (_collections is EqualUnmodifiableListView) return _collections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'User(userId: $userId, email: $email, password: $password, firstName: $firstName, lastName: $lastName, gender: $gender, birthdate: $birthdate, phone: $phone, location: $location, categories: $categories, isPhoneVerified: $isPhoneVerified, isEmailVerified: $isEmailVerified, attempts: $attempts, canUpdatePhoneCode: $canUpdatePhoneCode, accountType: $accountType, images: $images, videos: $videos, tracks: $tracks, collections: $collections)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.isPhoneVerified, isPhoneVerified) ||
                other.isPhoneVerified == isPhoneVerified) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified) &&
            (identical(other.attempts, attempts) ||
                other.attempts == attempts) &&
            (identical(other.canUpdatePhoneCode, canUpdatePhoneCode) ||
                other.canUpdatePhoneCode == canUpdatePhoneCode) &&
            (identical(other.accountType, accountType) ||
                other.accountType == accountType) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality().equals(other._videos, _videos) &&
            const DeepCollectionEquality().equals(other._tracks, _tracks) &&
            const DeepCollectionEquality()
                .equals(other._collections, _collections));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        userId,
        email,
        password,
        firstName,
        lastName,
        gender,
        birthdate,
        phone,
        location,
        const DeepCollectionEquality().hash(_categories),
        isPhoneVerified,
        isEmailVerified,
        attempts,
        canUpdatePhoneCode,
        accountType,
        const DeepCollectionEquality().hash(_images),
        const DeepCollectionEquality().hash(_videos),
        const DeepCollectionEquality().hash(_tracks),
        const DeepCollectionEquality().hash(_collections)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  factory _User(
      {required final String userId,
      required final String email,
      final String? password,
      final String? firstName,
      final String? lastName,
      final String? gender,
      final DateTime? birthdate,
      final String? phone,
      final String? location,
      final List<String>? categories,
      final bool? isPhoneVerified,
      final bool? isEmailVerified,
      required final int attempts,
      required final bool canUpdatePhoneCode,
      final String? accountType,
      final List<String>? images,
      final List<String>? videos,
      final List<String>? tracks,
      final List<String>? collections}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get userId;
  @override
  String get email;
  @override
  String? get password;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get gender;
  @override
  DateTime? get birthdate;
  @override
  String? get phone;
  @override
  String? get location;
  @override
  List<String>? get categories;
  @override
  bool? get isPhoneVerified;
  @override
  bool? get isEmailVerified;
  @override
  int get attempts;
  @override
  bool get canUpdatePhoneCode;
  @override
  String? get accountType;
  @override
  List<String>? get images;
  @override
  List<String>? get videos;
  @override
  List<String>? get tracks;
  @override
  List<String>? get collections;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
